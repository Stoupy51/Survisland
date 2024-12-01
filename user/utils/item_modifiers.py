
# Imports
from python_datapack.constants import *
from python_datapack.utils.print import *
from python_datapack.utils.io import *

# Generates item modifiers
def main(config: dict) -> None:
	namespace: str = config["namespace"]
	modifiers: str = f"{config['build_datapack']}/data/{namespace}/item_modifier"
	database: dict[str, dict] = config['database']

	# For each book, generate an item modifier to change item_model
	for item, data in database.items():
		if "book_" in item:
			model: str = data["item_model"]
			color: str = item.replace("book_", "")
			item_modifier: dict = {"function":"minecraft:set_components","components":{"minecraft:item_model":model}}
			write_to_file(f"{modifiers}/books/{color}.json", super_json_dump(item_modifier))

	# Switch scroll state
	normal: str = database["parchemin"]["item_model"]
	deployed: str = database["deployed_parchemin"]["item_model"]
	item_modifier: list[dict] = [
		{"function":"minecraft:set_components","components":{"minecraft:item_model":normal},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{"mainhand":{"components":{"minecraft:item_model":deployed}}}}}]},
		{"function":"minecraft:set_components","components":{"minecraft:item_model":deployed},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{"mainhand":{"components":{"minecraft:item_model":normal}}}}}]},
	]
	write_to_file(f"{modifiers}/switch_scroll_state.json", super_json_dump(item_modifier, max_level = -1))

	# Switch flambeau state
	normal: str = database["flambeau"]["item_model"]
	lighted: str = f"{normal}_on"
	for slot in ["mainhand", "offhand"]:
		item_modifier: list[dict] = [
			{"function":"minecraft:set_components","components":{"minecraft:item_model":normal},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{slot:{"components":{"minecraft:item_model":lighted}}}}}]},
			{"function":"minecraft:set_components","components":{"minecraft:item_model":lighted},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{slot:{"components":{"minecraft:item_model":normal}}}}}]},
		]
		write_to_file(f"{modifiers}/switch_flambeau_state/{slot}.json", super_json_dump(item_modifier, max_level = -1))

	pass

