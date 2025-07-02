
# Imports
from stewbeet import CUSTOM_ITEM_VANILLA, Equipment, Mem, Texture, set_json_encoder

# Constants
NECKLACES: list[str] = ["necklace", "cursed_necklace", "dinosaur_necklace"]

# Main function
def main() -> None:
	ns: str = Mem.ctx.project_id
	textures_folder: str = Mem.ctx.meta.get("stewbeet", {}).get("textures_folder", "")

	# Add each necklace
	for necklace in NECKLACES:
		Mem.definitions[necklace] = {
			"id": CUSTOM_ITEM_VANILLA,
			"max_stack_size": 1,
			"equippable": {
				"slot": "chest",
				"asset_id": f"{ns}:{necklace}",
				"damage_on_hurt": False
			}
		}

		# Copy texture in the humanoid equipment folder
		source: str = f"{textures_folder}/{necklace}_held.png"
		Mem.ctx.assets[ns].textures[f"entity/equipment/humanoid/{necklace}_held"] = Texture(source_path=source)

		# Write model
		model_data: dict = {"layers": {"humanoid": [{"texture": f"{ns}:{necklace}_held"}]}}
		Mem.ctx.assets[ns].equipments[necklace] = set_json_encoder(Equipment(model_data))

