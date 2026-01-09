
# Imports
from stewbeet import Equipment, Item, JsonDict, Mem, Texture, set_json_encoder

# Constants
NECKLACES: list[str] = ["necklace", "cursed_necklace", "dinosaur_necklace", "dragon_necklace", "dragon_flower_necklace"]

# Main function
def main() -> None:
	ns: str = Mem.ctx.project_id
	textures_folder: str = Mem.ctx.meta.get("stewbeet", {}).get("textures_folder", "")

	# Add each necklace
	for necklace in NECKLACES:
		obj = Item(
			id=necklace,
			components={
				"max_stack_size": 1,
				"equippable": {
					"slot": "chest",
					"asset_id": f"{ns}:{necklace}",
					"damage_on_hurt": False
				}
			}
		)
		if necklace.startswith("dragon_"):
			obj.override_model = {
				"parent": "item/generated",
				"textures": {
					"layer0": f"{ns}:item/{necklace}",
					"layer1": f"{ns}:item/{necklace}_overlay"
				}
			}

		# Copy texture in the humanoid equipment folder
		source: str = f"{textures_folder}/{necklace}_held.png"
		Mem.ctx.assets[ns].textures[f"entity/equipment/humanoid/{necklace}_held"] = Texture(source_path=source)
		if necklace.startswith("dragon_"):
			source_overlay: str = f"{textures_folder}/{necklace}_held_overlay.png"
			Mem.ctx.assets[ns].textures[f"entity/equipment/humanoid/{necklace}_held_overlay"] = Texture(source_path=source_overlay)

		# Write model
		if not necklace.startswith("dragon_"):
			model_data: JsonDict = {"layers": {"humanoid": [{"texture": f"{ns}:{necklace}_held"}]}}
		else:
			model_data = {
				"layers": {
					"humanoid": [
						{"texture": f"{ns}:{necklace}_held_overlay"},
						{"texture": f"{ns}:{necklace}_held", "dyeable": {"color_when_undyed": [1.0,1.0,1.0]}},
					]
				}
			}
		Mem.ctx.assets[ns].equipments[necklace] = set_json_encoder(Equipment(model_data), max_level=3)

