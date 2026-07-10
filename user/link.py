
# Imports
from stewbeet import Context, Mem, official_lib_used
from stewbeet.dependencies import OFFICIAL_LIBS

from user.utils.dyeable_items import main as generate_dyeable_items
from user.utils.font import main as generate_screamer
from user.utils.item_modifiers import main as generate_books_modifiers
from user.utils.parchemins import main as generate_parchemins
from user.utils.pendent import main as generate_pendent
from user.utils.pop_ups import main as generate_pop_ups
from user.utils.right_click import main as generate_right_click
from user.utils.scheduled_functions import main as generate_scheduled_functions
from user.utils.url import main as generate_url


# Main function is run just before making finalyzing the build process (zip, headers, lang, ...)
def beet_default(ctx: Context) -> None:
	generate_scheduled_functions()
	generate_right_click()
	generate_dyeable_items()
	generate_parchemins()
	generate_pendent()
	generate_url()
	generate_books_modifiers()
	generate_pop_ups()
	generate_screamer()

	# Force enable a all modules from Bookshelf (https://docs.mcbookshelf.dev/en/latest/modules/dump.html)
	for module in OFFICIAL_LIBS.keys():
		if module.startswith("bs.") or module.startswith("smithed."):
			official_lib_used(module)

	# Delete quick actions (manual)
	if Mem.ctx.data["minecraft"].dialogs_tags.get("quick_actions"):
		del Mem.ctx.data["minecraft"].dialogs_tags["quick_actions"]

	# Prevent some crafts
	Mem.ctx.data.mcmeta.data["filter"] = {
		"block": [
			{"namespace": "minecraft","path": "recipe/composter"}
		]
	}

