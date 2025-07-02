
# Import database helper
from stewbeet import (
	CUSTOM_ITEM_VANILLA,
	Context,
	Mem,
	add_item_model_component,
	add_item_name_and_lore_if_missing,
	add_private_custom_data_for_namespace,
	add_smithed_ignore_vanilla_behaviours_convention,
	generate_custom_records,
)

# Imports
from user.database.base import main as make_database
from user.database.necklaces import main as make_necklaces
from user.database.tribe_civilization import main as make_tribe_civilization


# Main function should return a database
def beet_default(ctx: Context) -> None:
	if Mem.ctx is None:
		Mem.ctx = ctx

	# Apply database
	make_database()
	make_necklaces()
	make_tribe_civilization()

	# Generate custom disc records
	generate_custom_records("auto")

	# Final adjustments
	add_item_model_component()
	add_item_name_and_lore_if_missing()
	add_private_custom_data_for_namespace()
	add_smithed_ignore_vanilla_behaviours_convention()

	# Remaining data
	iron_bowl: dict = Mem.definitions["iron_bowl"]
	for rice in ["rice", "cooked_rice"]:
		Mem.definitions[rice]["use_remainder"] = {
			"count": 1,
			"id": CUSTOM_ITEM_VANILLA,
			"components": {
				"item_name": iron_bowl["item_name"],
				"item_model": iron_bowl["item_model"],
				"lore": iron_bowl["lore"]
			}
		}

