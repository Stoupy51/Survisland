
# Imports

import stouputils as stp
from beet import ItemTag, Recipe
from stewbeet import Item, ItemModel, JsonDict, Mem, set_json_encoder


# Makes parchemins & cushions tintables (dye recipes, cauldron washing, tinted item models)
def main() -> None:
	ns: str = Mem.ctx.project_id

	# Make parchemins & cushions tintables
	# (26.1 removed #minecraft:dyeable: dyeing is now a per-item "minecraft:crafting_dye" recipe, and cauldron washing is the #minecraft:cauldron_can_remove_dye tag)
	parchemin = Item.from_id("parchemin")
	cushion = Item.from_id("cushion")
	dyeable_bases: list[str] = stp.unique_list([parchemin.base_item, cushion.base_item])
	for base_item in dyeable_bases:
		Mem.ctx.data[ns].recipes[f"dye_{base_item.split(':')[-1]}"] = set_json_encoder(Recipe({
			"type": "minecraft:crafting_dye",
			"dye": "#minecraft:dyes",
			"target": base_item,
			"result": {"id": base_item}
		}))
	Mem.ctx.data["minecraft"].item_tags["cauldron_can_remove_dye"] = set_json_encoder(ItemTag({"values":dyeable_bases}))
	add_dye_tint("parchemin", [0.780, 0.737, 0.647])
	add_dye_tint("deployed_parchemin", [0.780, 0.737, 0.647])
	add_dye_tint("cushion", [1.0, 1.0, 1.0])


# Inject a dye tint into every model entry of an already-generated items/ definition (keeps hand_model selects intact)
def add_dye_tint(name: str, default: list[float]) -> None:
	ns: str = Mem.ctx.project_id
	definition: JsonDict = Mem.ctx.assets[ns].item_models[name].data

	def walk(node: list[JsonDict] | JsonDict | None) -> None:
		if isinstance(node, dict):
			if node.get("type") == "minecraft:model":
				node["tints"] = [{"type": "minecraft:dye", "default": default}]
			for value in node.values():
				walk(value)
		elif isinstance(node, list):
			for value in node:
				walk(value)

	walk(definition)
	Mem.ctx.assets[ns].item_models[name] = set_json_encoder(ItemModel(definition), max_level=3)

