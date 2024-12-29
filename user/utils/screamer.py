
# Imports
from python_datapack.constants import *
from python_datapack.utils.print import *
from python_datapack.utils.io import *

# Generates trivial things in the datapack
def main(config: dict) -> None:
	namespace: str = config["namespace"]
	build_resource_pack: str = config["build_resource_pack"]
	assets_folder: str = config["assets_folder"]

	# Constants
	SCREAMER_TEXT: str = "S"

	# Make a font
	font_providers: dict[str, list[dict]] = {
		"providers": [
			{"type":"bitmap","file":f"{namespace}:font/shazinho.png","ascent":80,"height":160,"chars":[SCREAMER_TEXT]}
		]
	}
	write_to_file(f"{build_resource_pack}/assets/{namespace}/font/screamers.json", super_json_dump(font_providers))

	# Copy textures
	super_copy(f"{assets_folder}/shazinho.png", f"{build_resource_pack}/assets/{namespace}/textures/font/shazinho.png")

	# Make a function to make the shazinho screamer
	write_to_function(config, f"{namespace}:utils/pas_touche_1", f"""
title @s times 0 0 40
title @s title {{"text":"{SCREAMER_TEXT}","font":"{namespace}:screamers"}}
execute at @s run playsound {namespace}:vine_boom
""")
	write_to_function(config, f"{namespace}:utils/pas_touche_2", f"""
title @s times 0 40 40
title @s title {{"text":"{SCREAMER_TEXT}","font":"{namespace}:screamers"}}
execute at @s run playsound {namespace}:scary_screamer
""")
	write_to_function(config, f"{namespace}:utils/pas_touche_3", f"""
title @s times 0 40 40
title @s title {{"text":"{SCREAMER_TEXT}","font":"{namespace}:screamers"}}
execute at @s run playsound {namespace}:fart_reverb
""")

	pass

