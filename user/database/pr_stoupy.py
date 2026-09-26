# ruff: noqa: E501
# Imports
from stewbeet import Item, JsonDict, Mem

# Constants
RAT_VARIANTS: tuple[str, ...] = ("grey", "white", "brown", "mutant")
""" Rat models, each one an item named rat_<variant> textured by assets/textures/pr_stoupy/rat_<variant>.png. """

FUR: list[float] = [0, 0, 8, 8]
BELLY: list[float] = [8, 0, 12, 4]
SKIN: list[float] = [12, 0, 16, 4]
FACE: list[float] = [8, 4, 12, 8]
TAIL: list[float] = [12, 4, 16, 8]
""" Regions of the 16x16 rat texture, as face UVs. """


# Functions
def cuboid(start: list[float], end: list[float], uv: list[float], front: list[float] | None = None, bottom: list[float] | None = None, rotation: JsonDict | None = None) -> JsonDict:
	""" Build a model element whose faces all use one texture region, apart from its front (north) and its bottom. """
	faces: JsonDict = {side: {"uv": uv, "texture": "#0"} for side in ("east", "south", "west", "up")}
	faces["north"] = {"uv": front or uv, "texture": "#0"}
	faces["down"] = {"uv": bottom or uv, "texture": "#0"}
	element: JsonDict = {"from": start, "to": end, "faces": faces}
	if rotation:
		element["rotation"] = rotation
	return element


def rat_model(texture: str) -> JsonDict:
	""" Low poly rat facing north, the side an item display turns toward its own yaw. """
	return {
		"textures": {"0": texture, "particle": texture},
		"elements": [
			cuboid([4.5, 1, 4],     [11.5, 5.5, 12],  FUR, bottom=BELLY),
			cuboid([5.5, 1.5, 0.5], [10.5, 5, 4.5],   FUR, front=FACE, bottom=BELLY),
			cuboid([7, 1.5, -0.5],  [9, 3, 0.5],      SKIN),
			cuboid([5.5, 4.5, 2.5], [7, 6.5, 3],      SKIN),
			cuboid([9, 4.5, 2.5],   [10.5, 6.5, 3],   SKIN),
			cuboid([7.5, 2, 12],    [8.5, 3, 21],     TAIL, rotation={"angle": 22.5, "axis": "x", "origin": [8, 2.5, 12]}),
			cuboid([5, 0, 4.5],     [6.5, 1, 6],      SKIN),
			cuboid([9.5, 0, 4.5],   [11, 1, 6],       SKIN),
			cuboid([5, 0, 10],      [6.5, 1, 11.5],   SKIN),
			cuboid([9.5, 0, 10],    [11, 1, 11.5],    SKIN),
		],
	}


def main() -> None:
	""" Add the items of the lab: the black hole marker cube and the rat models. """
	ns: str = Mem.ctx.project_id

	# Solid "SVL" marker texture turned into the black hole by the item shader
	Item(id="black_hole", override_model={"parent": "minecraft:block/cube_all"})

	for variant in RAT_VARIANTS:
		Item(id=f"rat_{variant}", override_model=rat_model(f"{ns}:item/rat_{variant}"))

