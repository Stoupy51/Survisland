
# Imports
import stouputils as stp
from stewbeet import Item, JsonDict, Mem


# Main function
def main() -> None:
	ns: str = Mem.ctx.project_id
	assets: str = f"{Mem.ctx.directory}/assets"

	model: JsonDict = stp.json_load(f"{assets}/models/cushion.json")
	for key in model["textures"]:
		model["textures"][key] = f"{ns}:item/cushion_model"

	Item(
		id="cushion",
		base_item="minecraft:warped_fungus_on_a_stick",
		# TODO: spawn egg
		components={
		},
		override_model=model,
		hand_model={"parent": "item/handheld", "textures": {"layer0": f"{ns}:item/cushion"}}
	)

