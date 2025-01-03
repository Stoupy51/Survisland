
# Import database helper
from python_datapack.utils.database_helper import *

# Imports
from user.database.base import main as make_database
from user.database.necklaces import main as make_necklaces

# Main function should return a database
def main(config: dict) -> dict[str, dict]:

	# Apply database
	database: dict[str, dict] = make_database(config)
	make_necklaces(config, database)

	# Generate custom disc records
	generate_custom_records(config, database, "auto")

	# Final adjustments
	add_item_model_component(config, database)
	add_item_name_and_lore_if_missing(config, database)
	add_private_custom_data_for_namespace(config, database)
	add_smithed_ignore_vanilla_behaviours_convention(database)
	print()

	# Return database
	return database

