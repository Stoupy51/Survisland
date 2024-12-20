
# Import database helper
from python_datapack.utils.database_helper import *

# Imports
from .database.additions import main as make_database

# Main function should return a database
def main(config: dict) -> dict[str, dict]:

	# Apply database additions
	database: dict[str, dict] = make_database(config)

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

