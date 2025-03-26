
# Imports
import stouputils as stp
from python_datapack.utils.database_helper import *

# Constants
NECKLACES: list[str] = ["necklace", "cursed_necklace", "dinosaur_necklace"]

# Main function should return a database
def main(config: dict, database: dict[str, dict]) -> None:
	ns: str = config["namespace"]

	# Add each necklace
	for necklace in NECKLACES:
		database[necklace] = {
			"id": CUSTOM_ITEM_VANILLA,
			"max_stack_size": 1,
			"equippable": {
				"slot": "chest",
				"asset_id": f"{ns}:{necklace}",
				"damage_on_hurt": False
			}
		}

		# Copy texture in the humanoid equipment folder
		source: str = f"{config['assets_folder']}/textures/{necklace}_held.png"
		destination: str = f"{config['build_resource_pack']}/assets/{ns}/textures/entity/equipment/humanoid/{necklace}_held.png"
		super_copy(source, destination)

		# Write model
		model_file: str = f"{config['build_resource_pack']}/assets/{ns}/equipment/{necklace}.json"
		model_data: dict = {"layers": {"humanoid": [{"texture": f"{ns}:{necklace}_held"}]}}
		write_file(model_file, stp.super_json_dump(model_data))

