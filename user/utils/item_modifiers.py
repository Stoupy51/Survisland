
# Imports
from stewbeet import ItemModifier, Mem, set_json_encoder


# Generates item modifiers
def main() -> None:
	ns: str = Mem.ctx.project_id

	# For each book, generate an item modifier to change item_model
	for item, data in Mem.definitions.items():
		if "book_" in item:
			model: str = data["item_model"]
			color: str = item.replace("book_", "")
			item_modifier: dict = {"function":"minecraft:set_components","components":{"minecraft:item_model":model}}
			Mem.ctx.data[ns].item_modifiers[f"books/{color}"] = set_json_encoder(ItemModifier(item_modifier))

	# Switch scroll state
	normal: str = Mem.definitions["parchemin"]["item_model"]
	deployed: str = Mem.definitions["deployed_parchemin"]["item_model"]
	item_modifier: list[dict] = [
		{"function":"minecraft:set_components","components":{"minecraft:item_model":normal},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{"mainhand":{"components":{"minecraft:item_model":deployed}}}}}]},
		{"function":"minecraft:set_components","components":{"minecraft:item_model":deployed},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{"mainhand":{"components":{"minecraft:item_model":normal}}}}}]},
	]
	Mem.ctx.data[ns].item_modifiers["switch_scroll_state"] = set_json_encoder(ItemModifier(item_modifier), max_level=-1)

	# Switch flambeau state
	normal: str = Mem.definitions["flambeau"]["item_model"]
	lighted: str = f"{normal}_on"
	for slot in ["mainhand", "offhand"]:
		item_modifier: list[dict] = [
			{"function":"minecraft:set_components","components":{"minecraft:item_model":normal},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{slot:{"components":{"minecraft:item_model":lighted}}}}}]},
			{"function":"minecraft:set_components","components":{"minecraft:item_model":lighted},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{slot:{"components":{"minecraft:item_model":normal}}}}}]},
		]
		Mem.ctx.data[ns].item_modifiers[f"switch_flambeau_state/{slot}"] = set_json_encoder(ItemModifier(item_modifier), max_level=-1)

	pass

