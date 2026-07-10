
# Imports
from stewbeet import (
	Context,
	Item,
	Mem,
	add_item_model_component,
	add_item_name_and_lore_if_missing,
	add_private_custom_data_for_namespace,
	add_smithed_ignore_vanilla_behaviours_convention,
	export_all_definitions_to_json,
	generate_custom_records,
)

from user.database.accessories import main as make_accessories
from user.database.cosmetics import main as make_cosmetics
from user.database.cushions import main as make_cushions
from user.database.food import main as make_food
from user.database.generated import main as make_generated
from user.database.misc_items import main as make_misc_items
from user.database.modules.abyssion_wrath import main as make_abyssion_wrath
from user.database.modules.aube_ecarlate import main as make_aube_ecarlate
from user.database.modules.lefortdesrats import main as make_lefortdesrats
from user.database.nature import main as make_nature
from user.database.necklaces import main as make_necklaces
from user.database.scrolls import main as make_scrolls
from user.database.sudokucraft import main as make_sudokucraft
from user.database.tchoutchou import main as make_tchoutchou
from user.database.torches import main as make_torches
from user.database.tribe_civilization import main as make_tribe_civilization


# Main function should return a database
def beet_default(ctx: Context) -> None:

	# Apply database
	make_scrolls()
	make_cushions()
	make_accessories()
	make_cosmetics()
	make_food()
	make_generated()
	make_misc_items()
	make_nature()
	make_sudokucraft()
	make_torches()
	make_necklaces()
	make_tribe_civilization()
	make_tchoutchou()
	make_aube_ecarlate()
	make_abyssion_wrath()
	make_lefortdesrats()

	# Generate custom disc records
	generate_custom_records("auto")

	# Final adjustments
	add_item_model_component()
	add_item_name_and_lore_if_missing()
	add_private_custom_data_for_namespace()
	add_smithed_ignore_vanilla_behaviours_convention()

	# Remaining data
	iron_bowl = Item.from_id("iron_bowl")
	for rice in ["rice", "cooked_rice"]:
		Item.from_id(rice).components["use_remainder"] = {
			"count": 1,
			"id": iron_bowl.base_item,
			"components": {
				"item_name": iron_bowl.components["item_name"],
				"item_model": iron_bowl.components["item_model"],
				"lore": iron_bowl.components["lore"]
			}
		}

	export_all_definitions_to_json(f"{Mem.ctx.directory}/definitions_debug.json", Mem.definitions)

