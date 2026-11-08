
# Imports
import os

from stewbeet import Item, JsonDict, Mem

# Constants
DISPLAYS: tuple[str, ...] = (
	"thirdperson_righthand", "thirdperson_lefthand", "firstperson_righthand", "firstperson_lefthand",
	"ground", "gui", "head", "fixed", "on_shelf",
)


# Main function
def main() -> None:

	# Get textures
	textures_folder = str(Mem.ctx.meta.get("stewbeet", {}).get("textures_folder", ""))
	textures: list[str] = sorted(
		os.path.splitext(file)[0] for _, _, files in os.walk(textures_folder) for file in files if file.endswith(".png")
	)

	# Always enabled
	Item(id="blockguessr_map", base_item="minecraft:carrot_on_a_stick", override_model={
		"parent":"item/generated",
		"display":{
			"thirdperson_lefthand": {"scale": [0,0,0]},
			"thirdperson_righthand": {"scale": [0,0,0]}
		}
	})

	# If disabled in config, skip loading this module
	meta: JsonDict = Mem.ctx.meta["survisland"].get("modules", {}).get("blockguessr", {})
	if not meta.get("items", False):
		return

	# Add blockguessr screenshots
	for item in [x for x in textures if "blockguessr_" in x]:
		if "blockguessr_map" in item:
			continue

		from PIL import Image
		img = Image.open(f"{textures_folder}/blockguessr/{item}.png")
		x_on_y = img.width / img.height
		override_model: JsonDict = {"display": {x: {"scale": [0.5*x_on_y, 0.5, 0.5]} for x in DISPLAYS}}
		override_model["display"]["firstperson_righthand"] = {"scale": [0, 0, 0]}
		override_model["display"]["firstperson_lefthand"] = {"scale": [0, 0, 0]}
		Item(id=item, override_model=override_model)

