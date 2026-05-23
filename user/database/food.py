
# Imports
from stewbeet import Ingr, Item, Mem, SmeltingRecipe, SmokingRecipe


def main() -> None:
	ns: str = Mem.ctx.project_id

	Item(
		id="iron_bowl",
		components={"lore": [{"text":"Made by Emilou","color":"gold","italic":False}]}
	)

	Item(
		id="rice",
		base_item="minecraft:apple",
		manual_category="food",
		components={
			"lore": [{"text":"Made by Emilou","color":"gold","italic":False}],
			"max_stack_size": 1,
			"consumable": {
				"on_consume_effects": [{
					"type": "minecraft:apply_effects",
					"effects": [{"duration": 100, "id": "minecraft:poison", "show_icon": True}],
					"probability": 0.6
				}]
			},
			"food": {"nutrition": 2,"saturation": 1.2}
		}
	)

	Item(
		id="cooked_rice",
		base_item="minecraft:apple",
		manual_category="food",
		recipes=[
			SmeltingRecipe(ingredient=Ingr("rice", ns), cookingtime=200, experience=1.0, group="riz", category="food"),
			SmokingRecipe(ingredient=Ingr("rice", ns), cookingtime=100, experience=1.0, group="riz", category="food")
		],
		components={
			"lore": [{"text":"Made by Emilou","color":"gold","italic":False}],
			"max_stack_size": 1,
			"consumable": {},
			"food": {"nutrition": 20,"saturation": 12}
		}
	)

	Item(
		id="croissant",
		base_item="minecraft:apple",
		manual_category="food",
		recipes=[
			SmeltingRecipe(ingredient=Ingr("minecraft:bread"), cookingtime=200, experience=1.0, group="croissant", category="food"),
			SmokingRecipe(ingredient=Ingr("minecraft:bread"), cookingtime=100, experience=1.0, group="croissant", category="food")
		],
		components={
			"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
			"consumable": {},
			"food": {"nutrition": 6,"saturation": 7}
		}
	)

	Item(
		id="chocolatine",
		base_item="minecraft:apple",
		manual_category="food",
		components={
			"lore": [{"text":"Made by Fhara","color":"gold","italic":False}],
			"consumable": {},
			"food": {"nutrition": 5,"saturation": 6}
		}
	)

	Item(
		id="donut",
		base_item="minecraft:apple",
		manual_category="food",
		components={
			"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
			"consumable": {},
			"food": {"nutrition": 5,"saturation": 6}
		}
	)

	Item(
		id="chocolate_eclair",
		base_item="minecraft:apple",
		manual_category="food",
		components={
			"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
			"consumable": {},
			"food": {"nutrition": 5,"saturation": 6}
		}
	)

	Item(
		id="strawberry_pie",
		base_item="minecraft:apple",
		manual_category="food",
		components={
			"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
			"consumable": {},
			"food": {"nutrition": 5,"saturation": 6}
		}
	)

