
# Imports
from pathlib import Path

from beet import EntityTypeTag, ResourcePack
from stewbeet import Context, Mem, official_lib_used, set_json_encoder
from stewbeet.dependencies import OFFICIAL_LIBS

from user.database.idols import generate_pendent_system
from user.modes.all_together import main as generate_all_together
from user.modes.pr_stoupy import main as generate_pr_stoupy
from user.utils.cushion_placement import main as generate_cushion_placement
from user.utils.dyeable_items import main as generate_dyeable_items
from user.utils.font import main as generate_screamer
from user.utils.item_modifiers import main as generate_books_modifiers
from user.utils.parchemins import main as generate_parchemins
from user.utils.player_head import main as generate_player_head
from user.utils.pop_ups import main as generate_pop_ups
from user.utils.right_click import main as generate_right_click
from user.utils.scheduled_functions import main as generate_scheduled_functions
from user.utils.url import main as generate_url

# Constants
SHADER_OVERLAYS: dict[str, tuple[list[int], list[int]]] = {
	"shaders_26_3": ([93, 0], [100, 1]),
	"shaders_26_4": ([100, 2], [1000, 0]),
}
""" Folder of merge/overlays to the first and last resource pack format [major, minor] it applies to. The base pack's shaders are the 26.2 ones. """


# Main function is run just before making finalyzing the build process (zip, headers, lang, ...)
def beet_default(ctx: Context) -> None:
	generate_scheduled_functions()
	generate_right_click()
	generate_dyeable_items()
	generate_cushion_placement()
	generate_parchemins()
	generate_pendent_system()
	generate_url()
	generate_books_modifiers()
	generate_pop_ups()
	generate_screamer()
	generate_player_head()
	generate_all_together()
	generate_pr_stoupy()

	for name, (min_format, max_format) in SHADER_OVERLAYS.items():
		ctx.assets.overlays[name] = ResourcePack(path=Path("merge/overlays") / name, supported_formats=[min_format[0], max_format[0]], min_format=min_format, max_format=max_format)

	# Vendored in libs/datapack with its sleep messages fixed for 26.2, where "interpret" no longer parses JSON strings
	del OFFICIAL_LIBS["smithed.actionbar"]

	# Force enable a all modules from Bookshelf (https://docs.mcbookshelf.dev/en/latest/modules/dump.html)
	for module in OFFICIAL_LIBS:
		if module.startswith(("bs.", "smithed.")) or module in ("cinemalya",):
			official_lib_used(module)

	# Delete quick actions (manual)
	if Mem.ctx.data["minecraft"].dialogs_tags.get("quick_actions"):
		del Mem.ctx.data["minecraft"].dialogs_tags["quick_actions"]

	# Pigs (shopping kart), chickens and striders keep their rider under water
	Mem.ctx.data["minecraft"].entity_type_tags["dismounts_underwater"] = set_json_encoder(EntityTypeTag({"replace": True, "values": [
		"camel", "donkey", "happy_ghast", "horse", "llama", "mule", "ravager", "spider", "trader_llama", "zombie_horse",
	]}))

	# Prevent some crafts
	Mem.ctx.data.mcmeta.data["filter"] = {
		"block": [
			{"namespace": "minecraft","path": "recipe/composter"}
		]
	}

