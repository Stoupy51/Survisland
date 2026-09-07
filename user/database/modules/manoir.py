
# Imports
from stewbeet import Item, JsonDict, Mem, generate_custom_records

# Constants
RECORD_MODEL: str = "minecraft:music_disc_13"
""" Vanilla music disc model worn by every aventurier record. """


# Main function
def main() -> None:

	# If disabled in config, skip loading this module
	meta: JsonDict = Mem.ctx.meta["survisland"].get("modules", {}).get("manoir", {})
	if not meta.get("sounds", False):
		Mem.ctx.meta["stewbeet"]["sounds"]["exclude_patterns"].append("manoir/*")
		return

	# The record generator registers these sounds itself, so the sounds plugin must not do it too
	Mem.ctx.meta["stewbeet"]["sounds"]["exclude_patterns"].append("manoir/aventurier_*.ogg")

	# Generate one record per aventurier, read straight from the manoir sounds folder
	records_folder: str = Mem.ctx.meta["stewbeet"]["records_folder"]
	Mem.ctx.meta["stewbeet"]["records_folder"] = f"{Mem.ctx.directory}/assets/sounds/manoir"
	generate_custom_records({f"aventurier_{i}": f"aventurier_{i}.ogg" for i in range(1, 7)})
	Mem.ctx.meta["stewbeet"]["records_folder"] = records_folder

	# Wear a vanilla disc instead of asking for a custom texture
	for i in range(1, 7):
		Item.from_id(f"aventurier_{i}").components["item_model"] = RECORD_MODEL

