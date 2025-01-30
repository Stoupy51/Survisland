
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
	SCREAMER_SHAZ: str = "1"
	SCREAMER_STOUP: str = "2"

	# Make a font
	font_providers: dict[str, list[dict]] = {
		"providers": [
			{"type":"bitmap","file":f"{namespace}:font/shazinho.png","ascent":80,"height":160,"chars":[SCREAMER_SHAZ]},
			{"type":"bitmap","file":f"{namespace}:font/stoupinou.png","ascent":80,"height":160,"chars":[SCREAMER_STOUP]},
		]
	}
	write_to_file(f"{build_resource_pack}/assets/{namespace}/font/screamers.json", super_json_dump(font_providers))

	# Copy textures
	super_copy(f"{assets_folder}/shazinho.png", f"{build_resource_pack}/assets/{namespace}/textures/font/shazinho.png")
	super_copy(f"{assets_folder}/stoupinou.png", f"{build_resource_pack}/assets/{namespace}/textures/font/stoupinou.png")

	# Make a function to make the shazinho screamer
	for text, name in [(SCREAMER_SHAZ, "shaz"), (SCREAMER_STOUP, "stoup")]:
		write_to_function(config, f"{namespace}:utils/s/{name}_vine", f"""
title @s times 0 0 40
title @s title {{"text":"{text}","font":"{namespace}:screamers"}}
execute at @s run playsound {namespace}:vine_boom ambient
""")
		write_to_function(config, f"{namespace}:utils/s/{name}_scary", f"""
title @s times 0 40 40
title @s title {{"text":"{text}","font":"{namespace}:screamers"}}
execute at @s run playsound {namespace}:scary_screamer ambient
""")
		write_to_function(config, f"{namespace}:utils/s/{name}_fart", f"""
title @s times 0 0 40
title @s title {{"text":"{text}","font":"{namespace}:screamers"}}
execute at @s run playsound {namespace}:fart_reverb ambient
""")

	pass

