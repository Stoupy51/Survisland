
# Imports
import os

import stouputils as stp
from stewbeet import Item, JsonDict, Mem


# Main function
def main() -> None:
    
# Get textures
    textures_folder = str(Mem.ctx.meta.get("stewbeet", {}).get("textures_folder", ""))
    textures: list[str] = [os.path.splitext(file)[0] for _, _, files in os.walk(textures_folder) for file in files if file.endswith(".png")]

        # Add SCP items
    for item in [x for x in textures if "scp_" in x]:
        no_extension = os.path.splitext(item)[0]
        from PIL import Image
        img = Image.open(f"{textures_folder}/ae/{item}.png")
        x_on_y = img.width / img.height
        displays = ("thirdperson_righthand", "thirdperson_lefthand", "firstperson_righthand", "firstperson_lefthand", "ground", "gui", "head", "fixed", "on_shelf")
        override_model: JsonDict = {"display": {x: {"scale": [0.5*x_on_y, 0.5, 0.5]} for x in displays}}
        override_model["display"]["firstperson_righthand"] = {"scale": [0, 0, 0]}
        override_model["display"]["firstperson_lefthand"] = {"scale": [0, 0, 0]}
        Item(id=no_extension, override_model=override_model)
        

    displays = ("thirdperson_righthand", "thirdperson_lefthand", "firstperson_righthand", "firstperson_lefthand", "ground", "gui", "head", "fixed", "on_shelf")
    override_model: JsonDict = {"display": {x: {"scale": [1, 1, 1]} for x in displays}}
    override_model["display"]["firstperson_righthand"] = {"scale": [0, 0, 0]}
    override_model["display"]["firstperson_lefthand"] = {"scale": [0, 0, 0]}
    Item(id="lock_door", base_item="minecraft:carrot_on_a_stick", manual_category="misc", override_model=override_model)