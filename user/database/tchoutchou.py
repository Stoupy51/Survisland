
# Imports
import stouputils as stp
from stewbeet import Item, JsonDict, Mem


# Main function
def main() -> None:
	ns: str = Mem.ctx.project_id
	tchou_folder: str = f"{Mem.ctx.directory}/assets/models/tchoutchou"

	# Add blocks
	for id in ("chest_wagon","craft_wagon_empty","craft_wagon_full","locomotive_fast","locomotive_slow"):

		# Load model
		model: JsonDict = stp.json_load(f"{tchou_folder}/{id}.json")
		model["textures"] = {
			"0": f"{ns}:item/{id}",
			"particle": f"{ns}:item/{id}"
		}

		# Add custom block
		Item(id=id, override_model=model)

