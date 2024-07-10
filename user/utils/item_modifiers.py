
# Imports
from python_datapack.constants import *
from python_datapack.utils.print import *
from python_datapack.utils.io import *

# Generates item modifiers
def main(config: dict) -> None:
	namespace: str = config["namespace"]
	modifiers: str = f"{config['build_datapack']}/data/{namespace}/item_modifier"
	database: dict[str, dict] = config['database']

	# For each book, generate an item modifier to change custom_model_data
	for item, data in database.items():
		if "book_" in item:
			cmd: int = data["custom_model_data"]
			color: str = item.replace("book_", "")
			item_modifier: dict = {"function":"minecraft:set_components","components":{"minecraft:custom_model_data":cmd}}
			write_to_file(f"{modifiers}/books/{color}.json", super_json_dump(item_modifier))

	# Switch scroll state
	normal: int = database["parchemin"]["custom_model_data"]
	deployed: int = database["deployed_parchemin"]["custom_model_data"]
	item_modifier: list[dict] = [
		{"function":"minecraft:set_components","components":{"minecraft:custom_model_data":normal},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{"mainhand":{"components":{"minecraft:custom_model_data":deployed}}}}}]},
		{"function":"minecraft:set_components","components":{"minecraft:custom_model_data":deployed},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{"mainhand":{"components":{"minecraft:custom_model_data":normal}}}}}]},
	]
	write_to_file(f"{modifiers}/switch_scroll_state.json", super_json_dump(item_modifier, max_level = -1))

	# Switch flambeau state
	normal: int = database["flambeau"]["custom_model_data"]
	lighted: int = normal + 1
	for slot in ["mainhand", "offhand"]:
		item_modifier: list[dict] = [
			{"function":"minecraft:set_components","components":{"minecraft:custom_model_data":normal},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{slot:{"components":{"minecraft:custom_model_data":lighted}}}}}]},
			{"function":"minecraft:set_components","components":{"minecraft:custom_model_data":lighted},"conditions":[{"condition":"minecraft:entity_properties","entity":"this","predicate":{"equipment":{slot:{"components":{"minecraft:custom_model_data":normal}}}}}]},
		]
		write_to_file(f"{modifiers}/switch_flambeau_state/{slot}.json", super_json_dump(item_modifier, max_level = -1))

	pass

