
# ruff: noqa: E501
# Imports
import stouputils as stp
from beet import ItemTag, Recipe
from stewbeet import Item, ItemModel, Mem, set_json_encoder


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
	Mem.ctx.assets[ns].item_models["parchemin"] = set_json_encoder(ItemModel({"model":{"type":"minecraft:model","model":f"{ns}:item/parchemin","tints":[{"type":"minecraft:dye","default":[0.780,0.737,0.647]}]}}), max_level=3)
	Mem.ctx.assets[ns].item_models["deployed_parchemin"] = set_json_encoder(ItemModel({"model":{"type":"minecraft:model","model":f"{ns}:item/deployed_parchemin","tints":[{"type":"minecraft:dye","default":[0.780,0.737,0.647]}]}}), max_level=3)
	Mem.ctx.assets[ns].item_models["cushion"] = set_json_encoder(ItemModel({"model":{"type":"minecraft:model","model":f"{ns}:item/cushion","tints":[{"type":"minecraft:dye","default":[1.0,1.0,1.0]}]}}), max_level=3)

