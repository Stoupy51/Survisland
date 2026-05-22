
# Imports
from stewbeet import Item


def main() -> None:

	Item(id="icon")
	Item(id="laser_gun", components={"max_stack_size": 64})

	Item(
		id="coord_stick",
		base_item="minecraft:warped_fungus_on_a_stick",
		components={
			"item_model": "minecraft:stick",
			"enchantment_glint_override": True,
		}
	)

	Item(id="temp_item", components={"item_model": "air"})
	Item(id="black_letter", base_item="minecraft:written_book")

	Item(id="monocoin", manual_category="misc")
	Item(id="super_star", manual_category="misc")
	Item(id="red_coin", manual_category="misc")
	Item(id="piece_sos", manual_category="misc", components={"item_name": {"text":"Pièce SOS","color":"light_purple","italic":False}})
	Item(id="grimoire", manual_category="misc")

	# Cards 0 to 8
	for i in range(0, 9):
		Item(
			id=f"card_{i}",
			manual_category="misc",
			components={"lore": [{"text":"Made by Canfav","color":"gold","italic":False}]}
		)

	Item(id="gland", manual_category="misc")
	Item(id="water_gun", manual_category="misc")
	Item(id="pass_du_bureau_de_giovanni", manual_category="misc")
	Item(id="filet_a_papillons", manual_category="misc")

