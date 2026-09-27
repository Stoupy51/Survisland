
# ruff: noqa: E501
# Imports
from dataclasses import dataclass

from beet import Model
from stewbeet import Item, ItemModel, JsonDict, Mem, set_json_encoder


# Classes
@dataclass(frozen=True)
class HatPart:
	""" One box of a rat hat, in the pixel space of the rat model, whose head faces north. """
	start: tuple[float, float, float]
	end: tuple[float, float, float]
	texture: str
	""" Vanilla block texture, ex: "block/black_wool". """


@dataclass(frozen=True)
class RatHat:
	""" A mini hat laid on the head of a rat, picked by the first custom_model_data string of the rat item. """
	name: str
	parts: list[HatPart]


# Constants
RAT_VARIANTS: tuple[str, ...] = ("grey", "white", "brown", "mutant")
""" Rat models, each one an item named rat_<variant> textured by assets/textures/pr_stoupy/rat_<variant>.png. """

RAT_HATS: list[RatHat] = [
	RatHat(name="top_hat", parts=[
		HatPart(start=(6, 5, 0.5),         end=(10, 5.5, 4.5),         texture="block/black_wool"),
		HatPart(start=(6.75, 5.5, 1.25),   end=(9.25, 8.5, 3.75),      texture="block/black_wool"),
		HatPart(start=(6.65, 5.5, 1.15),   end=(9.35, 6.25, 3.85),     texture="block/red_wool"),
	]),
	RatHat(name="party_hat", parts=[
		HatPart(start=(6.5, 5, 1),         end=(9.5, 6, 4),            texture="block/pink_concrete"),
		HatPart(start=(7, 6, 1.5),         end=(9, 7, 3.5),            texture="block/yellow_concrete"),
		HatPart(start=(7.5, 7, 2),         end=(8.5, 8, 3),            texture="block/pink_concrete"),
		HatPart(start=(7.75, 8, 2.25),     end=(8.25, 8.75, 2.75),     texture="block/light_blue_concrete"),
	]),
	RatHat(name="crown", parts=[
		HatPart(start=(6.5, 5, 1),         end=(9.5, 6, 4),            texture="block/gold_block"),
		HatPart(start=(6.5, 6, 1),         end=(7.25, 7, 1.75),        texture="block/gold_block"),
		HatPart(start=(8.75, 6, 1),        end=(9.5, 7, 1.75),         texture="block/gold_block"),
		HatPart(start=(6.5, 6, 3.25),      end=(7.25, 7, 4),           texture="block/gold_block"),
		HatPart(start=(8.75, 6, 3.25),     end=(9.5, 7, 4),            texture="block/gold_block"),
		HatPart(start=(7.5, 5.25, 0.9),    end=(8.5, 5.75, 1),         texture="block/redstone_block"),
	]),
	RatHat(name="chef_hat", parts=[
		HatPart(start=(6.5, 5, 1),         end=(9.5, 6, 4),            texture="block/white_wool"),
		HatPart(start=(6, 6, 0.5),         end=(10, 8, 4.5),           texture="block/white_wool"),
	]),
	RatHat(name="wizard_hat", parts=[
		HatPart(start=(6, 5, 0.5),         end=(10, 5.5, 4.5),         texture="block/purple_wool"),
		HatPart(start=(6.75, 5.5, 1.25),   end=(9.25, 6.75, 3.75),     texture="block/purple_wool"),
		HatPart(start=(7.25, 6.75, 1.75),  end=(8.75, 8, 3.25),        texture="block/purple_wool"),
		HatPart(start=(7.625, 8, 2.125),   end=(8.375, 9.25, 2.875),   texture="block/purple_wool"),
		HatPart(start=(7.4, 6, 1.15),      end=(8.1, 6.7, 1.25),       texture="block/gold_block"),
	]),
]
""" Hats a rat can wear, one picked at random when it is summoned. """

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


def hat_model(hat: RatHat) -> JsonDict:
	""" Block model of a hat, each part textured on all its faces with UVs following its size. """
	textures: list[str] = list(dict.fromkeys(part.texture for part in hat.parts))
	return {
		"textures": {"particle": textures[0]} | {str(index): texture for index, texture in enumerate(textures)},
		"elements": [
			{"from": part.start, "to": part.end, "faces": {side: {"texture": f"#{textures.index(part.texture)}"} for side in ("north", "east", "south", "west", "up", "down")}}
			for part in hat.parts
		],
	}


def add_rat_hats() -> None:
	""" Write the hat models, and turn every rat item into its model plus the hat named by its custom_model_data. """
	ns: str = Mem.ctx.project_id
	for hat in RAT_HATS:
		Mem.ctx.assets[ns].models[f"item/rat_hat/{hat.name}"] = set_json_encoder(Model(hat_model(hat)), max_level=4)

	hat_select: JsonDict = {
		"type": "minecraft:select",
		"property": "minecraft:custom_model_data",
		"cases": [{"when": hat.name, "model": {"type": "minecraft:model", "model": f"{ns}:item/rat_hat/{hat.name}"}} for hat in RAT_HATS],
		"fallback": {"type": "minecraft:empty"},
	}
	for variant in RAT_VARIANTS:
		Mem.ctx.assets[ns].item_models[f"rat_{variant}"] = set_json_encoder(ItemModel({"model": {
			"type": "minecraft:composite",
			"models": [{"type": "minecraft:model", "model": f"{ns}:item/rat_{variant}"}, hat_select],
		}}), max_level=4)

