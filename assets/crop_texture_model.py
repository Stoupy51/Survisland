"""
compact_texture.py — strip unused ("void") space out of a Minecraft/Blockbench
texture and rewrite the model UVs so nothing moves visually.

Unlike a plain autocrop, this does NOT just trim borders: it collects every
rectangle actually referenced by a UV in the model(s), cuts those out as
sprites, and bin-packs them into the smallest atlas that fits. Everything the
model never looks at is thrown away, including holes in the middle.

Usage:
    python compact_texture.py arrow.png arrow.json [more_models.json ...] \
        [-o outdir] [--padding 1] [--extrude] [--pot] [--dry-run]

Notes:
  * Minecraft model UVs live in a 0..16 space spanning the WHOLE texture, so
    `pixel = uv / 16 * actual_png_size`. The `texture_size` field is Blockbench
    metadata and may be stale -- it is rewritten, never trusted.
  * Several models can share one texture — pass them all, or referenced pixels
    belonging to the models you left out will be deleted.
"""

import argparse
import json
import math
import os
import sys

from PIL import Image

EPS = 1e-3
FACES = ("north", "east", "south", "west", "up", "down")


# ---------------------------------------------------------------- helpers
def snap(v):
    """UVs come out of Blockbench with float noise (675.9999 -> 676)."""
    r = round(v)
    return float(r) if abs(v - r) < EPS else v


def uv_to_px(u, v, tw, th):
    return snap(u / 16.0 * tw), snap(v / 16.0 * th)


def px_to_uv(x, y, tw, th):
    return snap(x * 16.0 / tw), snap(y * 16.0 / th)


def fmt(x):
    """Keep the JSON tidy: ints stay ints, floats get trimmed."""
    x = snap(x)
    if abs(x - round(x)) < 1e-9:
        return int(round(x))
    return round(x, 6)


# ---------------------------------------------------------------- collection
class FaceRef:
    __slots__ = ("model", "elem", "name", "u1", "v1", "u2", "v2", "group")

    def __init__(self, model, elem, name, uv):
        self.model = model
        self.elem = elem
        self.name = name
        self.u1, self.v1, self.u2, self.v2 = uv


def collect_faces(models, tex_name=None, tex_key=None):
    """Keep only the faces painted with the texture we are compacting.

    Filtering only matters when a model uses more than one texture. With a
    single texture we take every face, whatever the PNG happens to be called.
    """
    all_faces = []
    for path, data in models:
        for element in data.get("elements", []):
            for name in FACES:
                face = element.get("faces", {}).get(name)
                if not face or "uv" not in face:
                    continue
                key = str(face.get("texture", "#0")).lstrip("#")
                all_faces.append((FaceRef(path, element, name, face["uv"]), key, data))

    keys = {k for _, k, _ in all_faces}
    if tex_key is None and len(keys) <= 1:
        return [f for f, _, _ in all_faces]          # single texture: take everything

    if tex_key is None:                              # multi-texture: match by name
        hits = set()
        for _, k, data in all_faces:
            ref = data.get("textures", {}).get(k, "")
            if ref.split("/")[-1] == tex_name or ref.split(":")[-1] == tex_name:
                hits.add(k)
        if len(hits) != 1:
            sys.exit(
                f"'{tex_name}' matches {len(hits)} of the model's textures {sorted(keys)}.\n"
                f"Re-run with --texture-key to say which one to compact.")
        tex_key = hits.pop()

    return [f for f, k, _ in all_faces if k == str(tex_key).lstrip("#")]


def face_box(f, tw, th):
    """Integer pixel crop box covering the face, plus its exact float corners."""
    x1, y1 = uv_to_px(f.u1, f.v1, tw, th)
    x2, y2 = uv_to_px(f.u2, f.v2, tw, th)
    lo_x, hi_x = min(x1, x2), max(x1, x2)
    lo_y, hi_y = min(y1, y2), max(y1, y2)
    box = (
        int(math.floor(snap(lo_x))),
        int(math.floor(snap(lo_y))),
        max(int(math.ceil(snap(hi_x))), int(math.floor(snap(lo_x))) + 1),
        max(int(math.ceil(snap(hi_y))), int(math.floor(snap(lo_y))) + 1),
    )
    return box, (x1, y1, x2, y2)


def merge_overlapping(boxes):
    """Union any crop boxes that touch, so shared pixels aren't duplicated."""
    boxes = list(boxes)
    changed = True
    while changed:
        changed = False
        out = []
        for b in boxes:
            for i, o in enumerate(out):
                if b[0] < o[2] and o[0] < b[2] and b[1] < o[3] and o[1] < b[3]:
                    out[i] = (min(b[0], o[0]), min(b[1], o[1]),
                              max(b[2], o[2]), max(b[3], o[3]))
                    changed = True
                    break
            else:
                out.append(b)
        boxes = out
    return boxes


# ---------------------------------------------------------------- packing
def shelf_pack(sizes, width):
    """Sizes are (w, h). Returns placements or None if a sprite is too wide."""
    order = sorted(range(len(sizes)), key=lambda i: (-sizes[i][1], -sizes[i][0]))
    placed = [None] * len(sizes)
    x = y = shelf_h = 0
    for i in order:
        w, h = sizes[i]
        if w > width:
            return None
        if x + w > width:
            x, y, shelf_h = 0, y + shelf_h, 0
        placed[i] = (x, y)
        x += w
        shelf_h = max(shelf_h, h)
    return placed, width, y + shelf_h


def best_pack(sizes):
    """Try a spread of widths, keep the smallest-area result."""
    if not sizes:
        return [], 1, 1
    min_w = max(w for w, _ in sizes)
    total = sum(w * h for w, h in sizes)
    best = None
    cands = {min_w, sum(w for w, _ in sizes)}
    for k in range(0, 14):
        cands.add(max(min_w, int(math.sqrt(total) * (1.0 + 0.25 * k))))
        cands.add(max(min_w, 1 << k))
    for w in sorted(c for c in cands if c >= min_w):
        r = shelf_pack(sizes, w)
        if not r:
            continue
        placed, pw, ph = r
        used_w = max(placed[i][0] + sizes[i][0] for i in range(len(sizes)))
        area = used_w * ph
        key = (area, max(used_w, ph))
        if best is None or key < best[0]:
            best = (key, placed, used_w, ph)
    _, placed, w, h = best
    return placed, w, h


def pot(n):
    return 1 << (n - 1).bit_length()


# ---------------------------------------------------------------- main
def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("texture")
    ap.add_argument("models", nargs="+")
    ap.add_argument("-o", "--outdir", default="compacted")
    ap.add_argument("--padding", type=int, default=1,
                    help="gutter between sprites, in pixels (default 1)")
    ap.add_argument("--extrude", action="store_true",
                    help="bleed sprite edges into the gutter (mipmap safety)")
    ap.add_argument("--texture-key", default=None,
                    help="which entry in the model's `textures` map this PNG is "
                         "(only needed for multi-texture models)")
    ap.add_argument("--pot", action="store_true",
                    help="round the atlas up to a power of two")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    src = Image.open(args.texture).convert("RGBA")
    models = [(p, json.load(open(p, encoding="utf-8"))) for p in args.models]

    # UVs are 0..16 over the WHOLE texture, so the real PNG size is what counts.
    # `texture_size` is Blockbench metadata and can be stale -- never trust it here.
    tw, th = src.size
    for p, data in models:
        ts = data.get("texture_size")
        if ts and tuple(ts) != (tw, th):
            print(f"warning: {os.path.basename(p)} claims texture_size {ts[0]}x{ts[1]} "
                  f"but {os.path.basename(args.texture)} is {tw}x{th}. "
                  f"Using the real size ({tw}x{th}); the stale value is being corrected.")

    tex_name = os.path.splitext(os.path.basename(args.texture))[0]
    faces = collect_faces(models, tex_name, args.texture_key)
    if not faces:
        sys.exit(f"no faces in these models reference '{tex_name}'")

    # 1. every rectangle the model actually reads
    boxes, exact = [], []
    for f in faces:
        b, e = face_box(f, tw, th)
        boxes.append(b)
        exact.append(e)
    sprites = merge_overlapping(boxes)

    # 2. map each face onto the sprite that contains it
    for f, b in zip(faces, boxes):
        for i, s in enumerate(sprites):
            if b[0] >= s[0] and b[1] >= s[1] and b[2] <= s[2] and b[3] <= s[3]:
                f.group = i
                break

    # 3. pack
    pad = max(0, args.padding)
    sizes = [(s[2] - s[0] + 2 * pad, s[3] - s[1] + 2 * pad) for s in sprites]
    placed, W, H = best_pack(sizes)
    if args.pot:
        W, H = pot(W), pot(H)

    old_area, new_area = tw * th, W * H
    print(f"{len(faces)} faces -> {len(sprites)} sprites")
    print(f"atlas {tw}x{th} ({old_area:,} px) -> {W}x{H} ({new_area:,} px)  "
          f"= {new_area / old_area:.2%} of original")
    if args.dry_run:
        return

    # 4. blit
    dst = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    for s, (px, py) in zip(sprites, placed):
        tile = src.crop(s)
        if args.extrude and pad:
            grown = Image.new("RGBA", (tile.width + 2 * pad, tile.height + 2 * pad))
            for dx in range(-pad, pad + 1):
                for dy in range(-pad, pad + 1):
                    grown.paste(tile, (pad + dx, pad + dy))
            grown.paste(tile, (pad, pad))
            dst.paste(grown, (px, py))
        else:
            dst.paste(tile, (px + pad, py + pad))

    # 5. rewrite UVs  (pure translation, so mirrored/flipped UVs stay flipped)
    for f, e in zip(faces, exact):
        s = sprites[f.group]
        ox = placed[f.group][0] + pad - s[0]
        oy = placed[f.group][1] + pad - s[1]
        x1, y1, x2, y2 = e
        u1, v1 = px_to_uv(x1 + ox, y1 + oy, W, H)
        u2, v2 = px_to_uv(x2 + ox, y2 + oy, W, H)
        f.elem["faces"][f.name]["uv"] = [fmt(u1), fmt(v1), fmt(u2), fmt(v2)]

    for _, data in models:
        data["texture_size"] = [W, H]

    # 6. write
    os.makedirs(args.outdir, exist_ok=True)
    tex_out = os.path.join(args.outdir, os.path.basename(args.texture))
    dst.save(tex_out)
    print("wrote", tex_out)
    for p, data in models:
        mp = os.path.join(args.outdir, os.path.basename(p))
        with open(mp, "w", encoding="utf-8") as fh:
            json.dump(data, fh, indent=4, ensure_ascii=False)
            fh.write("\n")
        print("wrote", mp)


if __name__ == "__main__":
    main()

