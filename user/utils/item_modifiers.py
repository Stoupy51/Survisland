
# Imports
from copy import deepcopy
from typing import Any

from stewbeet import Item, ItemModifier, JsonDict, Mem, set_json_encoder


# Generates item modifiers
def main() -> None:
	ns: str = Mem.ctx.project_id

	# For each book, generate an item modifier to change item_model
	for item in Mem.definitions.keys():
		data = Item.from_id(item).components
		if "book_" in item:
			model: str = data["item_model"]
			color: str = item.replace("book_", "")
			item_modifier: JsonDict = {"function":"minecraft:set_components","components":{"minecraft:item_model":model}}
			Mem.ctx.data[ns].item_modifiers[f"books/{color}"] = set_json_encoder(ItemModifier(item_modifier))

	# Switch scroll state
	parchemin = Item.from_id("parchemin")
	deployed_parchemin = Item.from_id("deployed_parchemin")
	normal: str = parchemin.components["item_model"]
	deployed: str = deployed_parchemin.components["item_model"]
	item_modifiers: Any = [
		{"function":"minecraft:set_components","components":{"minecraft:item_model":normal},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{"mainhand":{"components":{"minecraft:item_model":deployed}}}}}]},
		{"function":"minecraft:set_components","components":{"minecraft:item_model":deployed},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{"mainhand":{"components":{"minecraft:item_model":normal}}}}}]},
	]
	Mem.ctx.data[ns].item_modifiers["switch_scroll_state"] = set_json_encoder(ItemModifier(item_modifiers), max_level=-1)

	# Switch flambeau state
	flambeau = Item.from_id("flambeau")
	normal: str = flambeau.components["item_model"]
	lighted: str = f"{normal}_on"

	# The "_on" variant is the extinguished torch (grey texture), so its flame must not be emissive
	# (deep copy because stewbeet shares the same elements list between both variants)
	extinguished_model = Mem.ctx.assets.models.get(f"{ns}:item/flambeau_on")
	if extinguished_model is not None:
		elements: list[JsonDict] = deepcopy(extinguished_model.data.get("elements", []))
		for element in elements:
			element.pop("light_emission", None)
		extinguished_model.data["elements"] = elements

	for slot in ["mainhand", "offhand"]:
		item_modifiers: Any = [
			{"function":"minecraft:set_components","components":{"minecraft:item_model":normal},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{slot:{"components":{"minecraft:item_model":lighted}}}}}]},
			{"function":"minecraft:set_components","components":{"minecraft:item_model":lighted},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{slot:{"components":{"minecraft:item_model":normal}}}}}]},
		]
		Mem.ctx.data[ns].item_modifiers[f"switch_flambeau_state/{slot}"] = set_json_encoder(ItemModifier(item_modifiers), max_level=-1)

	pass

