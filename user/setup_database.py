
# Import database helper
from python_datapack.utils.database_helper import *

# Imports
from .database.additions import main as make_database

# Constants
STARTING_CMD: int = 2010000	# Prefix for custom_model_data

# Main function should return a database
def main(config: dict) -> dict[str, dict]:

	# Apply database additions
	database: dict[str, dict] = make_database(config)

	# Generate custom disc records
	songs: list[str] = [x for x in os.listdir(config["assets_folder"] + "/records")]
	records: dict[str, str] = { file.replace(".ogg","").replace("-","_").replace(" ","_").replace("___","_").lower(): file for file in songs }
	generate_custom_records(config, database, records)

	# Final adjustments
	deterministic_custom_model_data(config, database, STARTING_CMD)
	clean_up_empty_recipes(database)
	add_item_name_and_lore_if_missing(config, database)
	add_private_custom_data_for_namespace(config, database)
	add_smithed_ignore_vanilla_behaviours_convention(database)
	print()

	# Return database
	return database

