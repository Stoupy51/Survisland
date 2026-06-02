
# Imports

import stouputils as stp
from stewbeet import SLOTS, Equipment, Item, JsonDict, Mem, Texture, set_json_encoder


# Main function
def main() -> None:
    ns: str = Mem.ctx.project_id
    models_folder: str = f"{Mem.ctx.directory}/assets/models/abyssion_wrath"
    textures_folder = str(Mem.ctx.meta.get("stewbeet", {}).get("textures_folder", ""))

    # If disabled in config, skip loading this module
    meta: JsonDict = Mem.ctx.meta["survisland"].get("modules", {}).get("abyssion_wrath", {})
    if not meta.get("sounds", False):
        Mem.ctx.meta["stewbeet"]["sounds"]["exclude_patterns"].append("abyssion_wrath/*")
    if not meta.get("items", False):
        return


    # Add 3d models for items
    ## Abyssion Crown
    model: JsonDict = stp.json_load(f"{models_folder}/abyssion_crown.json")
    for k in model["textures"].keys():
        model["textures"][k] = f"{ns}:item/abyssion_crown"
    Item(id="abyssion_crown", override_model=model, components={"max_stack_size": 1, "equippable": {"slot": "head"}})

    ## Scythe
    model = stp.json_load(f"{models_folder}/scythe.json")
    for k in model["textures"].keys():
        model["textures"][k] = f"{ns}:item/scythe"
    Item(id="scythe", base_item="minecraft:netherite_sword", override_model=model, components={"max_damage": 2026})


    # Add armors
    ## Add abyssion chestplate
    Item(
        id="abyssion_chestplate",
        base_item="minecraft:netherite_chestplate",
        components={
            "equippable": {"slot": "chest", "asset_id": f"{ns}:abyssion_armor"},
            "item_model": "minecraft:netherite_chestplate",
        }
    )
    Mem.ctx.assets[ns].textures["entity/equipment/humanoid/abyssion_layer_1"] = Texture(source_path=f"{textures_folder}/abyssion_wrath/abyssion_layer_1.png")
    Mem.ctx.assets[ns].equipments["abyssion_armor"] = set_json_encoder(Equipment({
        "layers": {
            "humanoid": [{"texture": f"{ns}:abyssion_layer_1"}],
        }
    }))

    ## Add abyssion skeleton as a new armor material
    for armor in ["helmet", "chestplate", "leggings", "boots"]:
        slot: str = SLOTS[armor]
        Item(
            id=f"abyssion_skeleton_{armor}",
            base_item=f"minecraft:chainmail_{armor}",
            components={
                "equippable": {"slot": slot, "asset_id": f"{ns}:abyssion_skeleton"},
                "item_model": f"minecraft:chainmail_{armor}",
            }
        )
    for layer in ["humanoid", "humanoid_leggings"]:
        Mem.ctx.assets[ns].textures[f"entity/equipment/{layer}/abyssion_skeleton"] = Texture(source_path=f"{textures_folder}/abyssion_wrath/abyssion_skeleton.png")
    Mem.ctx.assets[ns].equipments["abyssion_skeleton"] = set_json_encoder(Equipment({
        "layers": {
            "humanoid": [{"texture": f"{ns}:abyssion_skeleton"}],
            "humanoid_leggings": [{"texture": f"{ns}:abyssion_skeleton"}],
        }
    }))

