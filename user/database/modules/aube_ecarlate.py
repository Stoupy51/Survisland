
# Imports
import stouputils as stp
from stewbeet import Item, JsonDict, Mem, Painting, PaintingData

# Constants
DISPLAYS: tuple[str, ...] = ("thirdperson_righthand", "thirdperson_lefthand", "firstperson_righthand", "firstperson_lefthand", "ground", "gui", "head", "fixed", "on_shelf")

# Main function
def main() -> None:
    ns: str = Mem.ctx.project_id
    models_folder: str = f"{Mem.ctx.directory}/assets/models/ae"

    # If disabled in config, skip loading this module
    meta: JsonDict = Mem.ctx.meta["survisland"].get("modules", {}).get("aube_ecarlate", {})
    if not meta.get("sounds", False):
        Mem.ctx.meta["stewbeet"]["sounds"]["exclude_patterns"].append("ae/*")
    if not meta.get("items", False):
        return

    # Get textures
    textures_folder = str(Mem.ctx.meta.get("stewbeet", {}).get("textures_folder", ""))
    #textures: list[str] = [os.path.splitext(file)[0] for _, _, files in os.walk(textures_folder) for file in files if file.endswith(".png")]

    # Add SCP items
    for item in ("scp_173", "ae_106_1", "ae_106_2", "ae_106_dpt", "ae_173_doc", "ae_classd", "ae_zc_levers",):
        from PIL import Image
        img = Image.open(f"{textures_folder}/ae/{item}.png")
        x_on_y = img.width / img.height
        override_model: JsonDict = {"display": {x: {"scale": [0.5*x_on_y, 0.5, 0.5]} for x in DISPLAYS}}
        override_model["display"]["firstperson_righthand"] = {"scale": [0, 0, 0]}
        override_model["display"]["firstperson_lefthand"] = {"scale": [0, 0, 0]}
        Item(id=item, override_model=override_model, components={"equippable": {"slot":"mainhand","camera_overlay": f"{ns}:item/{item}"}})

    Item(id="ae_black_screen", base_item="minecraft:carved_pumpkin", override_model={"parent":"item/generated"})

    # Add Key Card
    Item(id="id_card_1", manual_category="misc")
    Item(id="id_card_2", manual_category="misc")
    Item(id="id_card_3", manual_category="misc")
    Item(id="id_card_4", manual_category="misc")

    # Add Plates
    Item(id="scp_008_plate", manual_category="misc")
    Item(id="scp_049_plate", manual_category="misc")
    Item(id="scp_096_plate", manual_category="misc")
    Item(id="scp_105_plate", manual_category="misc")
    Item(id="scp_106_plate", manual_category="misc")
    Item(id="scp_173_plate", manual_category="misc")
    Item(id="scp_330_plate", manual_category="misc")
    Item(id="scp_939_plate", manual_category="misc")
    Item(id="scp_966_plate", manual_category="misc")
    Item(id="scp_999_plate", manual_category="misc")
    Item(id="scp_1048_plate", manual_category="misc")

    # Add painting
    for item in ("ae_lockdown_cp_off", "ae_lockdown_cp_online"):
        Painting(id=item, painting_data=PaintingData(
            texture=f"painting/{item}",
            author={"text":"Chifu","color":"yellow"},
            width=3,
            height=2
        ))

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

