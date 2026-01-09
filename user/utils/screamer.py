
# Imports
from stewbeet import Font, JsonDict, Mem, Texture, set_json_encoder, write_function


# Generates trivial things in the datapack
def main() -> None:
	ns: str = Mem.ctx.project_id
	assets_folder: str = f"{Mem.ctx.directory}/assets"

	# Constants
	SCREAMER_SHAZ: str = "1"
	SCREAMER_STOUP: str = "2"

	# Make a font
	font_providers: dict[str, list[JsonDict]] = {
		"providers": [
			{"type":"bitmap","file":f"{ns}:font/shazinho.png","ascent":80,"height":160,"chars":[SCREAMER_SHAZ]},
			{"type":"bitmap","file":f"{ns}:font/stoupinou.png","ascent":80,"height":160,"chars":[SCREAMER_STOUP]},
		]
	}
	Mem.ctx.assets[ns].fonts["screamers"] = set_json_encoder(Font(font_providers))

	# Copy textures
	Mem.ctx.assets[ns].textures["font/shazinho"] = Texture(source_path=f"{assets_folder}/shazinho.png")
	Mem.ctx.assets[ns].textures["font/stoupinou"] = Texture(source_path=f"{assets_folder}/stoupinou.png")

	# Make a function to make the shazinho screamer
	for text, name in [(SCREAMER_SHAZ, "shaz"), (SCREAMER_STOUP, "stoup")]:
		write_function(f"{ns}:utils/s/{name}_vine", f"""
title @s times 0 0 40
title @s title {{"text":"{text}","font":"{ns}:screamers"}}
execute at @s run playsound {ns}:vine_boom ambient
""")
		write_function(f"{ns}:utils/s/{name}_scary", f"""
title @s times 0 40 40
title @s title {{"text":"{text}","font":"{ns}:screamers"}}
execute at @s run playsound {ns}:scary_screamer ambient
""")
		write_function(f"{ns}:utils/s/{name}_fart", f"""
title @s times 0 0 40
title @s title {{"text":"{text}","font":"{ns}:screamers"}}
execute at @s run playsound {ns}:fart_reverb ambient
""")

