
# Imports
import os

import stouputils as stp
from stewbeet import Item, JsonDict, Mem

# Constants
DISPLAYS: tuple[str, ...] = ("thirdperson_righthand", "thirdperson_lefthand", "firstperson_righthand", "firstperson_lefthand", "ground", "gui", "head", "fixed", "on_shelf")

# Main function
def main() -> None:
    ns: str = Mem.ctx.project_id
    models_folder: str = f"{Mem.ctx.directory}/assets/models/ae"

    # Get textures
    textures_folder = str(Mem.ctx.meta.get("stewbeet", {}).get("textures_folder", ""))
    #textures: list[str] = [os.path.splitext(file)[0] for _, _, files in os.walk(textures_folder) for file in files if file.endswith(".png")]

    # Add SCP items
    for item in ("scp_173",):
        no_extension = os.path.splitext(item)[0]
        from PIL import Image
        img = Image.open(f"{textures_folder}/ae/{item}.png")
        x_on_y = img.width / img.height
        override_model: JsonDict = {"display": {x: {"scale": [0.5*x_on_y, 0.5, 0.5]} for x in DISPLAYS}}
        override_model["display"]["firstperson_righthand"] = {"scale": [0, 0, 0]}
        override_model["display"]["firstperson_lefthand"] = {"scale": [0, 0, 0]}
        Item(id=no_extension, override_model=override_model)

    # Add lock door item (no visible in third person)
    override_model: JsonDict = {"display": {x: {"scale": [0, 0, 0]} for x in ("thirdperson_righthand", "thirdperson_lefthand")}}
    Item(id="lock_door", base_item="minecraft:carrot_on_a_stick", manual_category="misc", override_model=override_model)

    # Add 3d models for items
    ## Button
    for button in ("button", "button_pressed"):
        model: JsonDict = stp.json_load(f"{models_folder}/{button}.json")
        for k in model["textures"].keys():
            model["textures"][k] = f"{ns}:item/ae_button"
        Item(id=f"ae_{button}", override_model=model)

    ## Card pass
    for state in ("closed", "open"):
        model: JsonDict = stp.json_load(f"{models_folder}/card_pass_{state}.json")
        for k in model["textures"].keys():
            model["textures"][k] = f"{ns}:item/card_pass_{state}"
        Item(id=f"card_pass_{state}", override_model=model)

