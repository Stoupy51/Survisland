
# Imports
from python_datapack.constants import *
from python_datapack.utils.print import *
from python_datapack.utils.io import *

# Generates trivial things in the datapack
def main(config: dict) -> None:
	namespace: str = config["namespace"]
	build_resource_pack: str = config["build_resource_pack"]
	assets_folder: str = config["assets_folder"]

	# Make a font
	font_providers: dict[str, list[dict]] = {
		"providers": [
			{"type":"bitmap","file":f"{namespace}:font/screamer.png","ascent":80,"height":160,"chars":["S"]}
		]
	}
	write_to_file(f"{build_resource_pack}/assets/{namespace}/font/screamer.json", super_json_dump(font_providers))

	# Copy textures
	super_copy(f"{assets_folder}/screamer.png", f"{build_resource_pack}/assets/{namespace}/textures/font/screamer.png")

	# Make a function to make the screamer
	write_to_function(config, f"{namespace}:utils/pas_touche", f"""
title @s times 0 0 40
title @s title {{"text":"S","font":"{namespace}:screamer"}}
execute at @s run playsound {namespace}:vine_boom
""")

	pass

