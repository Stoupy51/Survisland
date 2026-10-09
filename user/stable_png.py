
# Imports
from pathlib import Path

from beet import Context, PngFile
from PIL import Image


# Generated PNGs (text renders, tooltips, ...) are re-encoded by Pillow on every build,
# and the zlib output differs between machines (Windows/Linux) even when pixels are identical.
# To avoid hundreds of binary diffs, reuse the bytes already in the build folder when the pixels didn't change.
# Must run before the archive plugin so zips get the same bytes.
def beet_default(ctx: Context) -> None:
	if not ctx.output_directory:
		return

	for pack in (ctx.data, ctx.assets):
		out_dir: Path = Path(ctx.output_directory) / pack.name
		for path, file in pack.list_files(".png", extend=PngFile):

			# Files copied from disk or already serialized are written as is
			if not isinstance(file._content, Image.Image):
				continue
			existing: Path = out_dir / path
			if not existing.is_file():
				continue

			old_bytes: bytes = existing.read_bytes()
			try:
				old: Image.Image = PngFile(old_bytes).image
				new: Image.Image = file.image
				same: bool = old.mode == new.mode and old.size == new.size and old.tobytes() == new.tobytes() and old.getpalette() == new.getpalette()
			except Exception:
				same = False
			if same:
				file.set_content(old_bytes)
