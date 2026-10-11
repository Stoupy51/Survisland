
# Imports
from pathlib import Path

import stouputils as stp
from stewbeet import Item, JsonDict, Mem


# Main function
def main() -> None:
	ns: str = Mem.ctx.project_id
	assets: Path = Mem.ctx.directory / "assets"

	def load_model(item_id: str, path: Path | str) -> JsonDict:
		""" Load a model from a JSON file and update its textures to use the correct namespace (unless it's a Minecraft texture). """
		model = stp.json_load(path)
		textures: JsonDict = model["textures"]
		textures.update({k: f"{ns}:item/{item_id}" for k, v in textures.items() if "minecraft:" not in v})
		for k in ("format_version", "texture_size"):
			if k in model:
				del model[k]
		return model

	Item(
		id="maracas",
		base_item="minecraft:diamond_sword",
		components={
			"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
			"equippable":{"slot":"chest","equip_sound":{"sound_id":"survisland:maracas"}}
		},
		override_model=load_model("maracas", f"{assets}/models/maracas.json")
	)

	Item(
		id="sombrero",
		components={
			"lore": [{"text":"Made by Fhara","color":"gold","italic":False}],
			"equippable":{"slot":"head"}
		},
		override_model=load_model("sombrero", f"{assets}/models/sombrero.json")
	)

	Item(
		id="visiere",
		components={
			"lore": [{"text":"Made by Fhara","color":"gold","italic":False}],
			"equippable":{"slot":"head"}
		},
		override_model=load_model("visiere", f"{assets}/models/visiere.json")
	)

	Item(
		id="toque",
		components={
			"lore": [{"text":"Made by Tata_Mymy","color":"gold","italic":False}],
			"equippable":{"slot":"head"}
		},
		override_model=load_model("toque", f"{assets}/models/toque.json")
	)

	Item(
		id="mask_re2",
		components={
			"lore": [{"text":"Made by Akwaden","color":"gold","italic":False}],
			"equippable": {"slot": "head"}
		},
		override_model=load_model("mask_re2", f"{assets}/models/mask_re2.json")
	)

