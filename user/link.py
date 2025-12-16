
# Imports
from stewbeet import BOOKSHELF_MODULES, Context, Mem, official_lib_used

from user.utils.item_modifiers import main as generate_books_modifiers
from user.utils.other import main as generate_other_things
from user.utils.pop_ups import main as generate_pop_ups
from user.utils.screamer import main as generate_screamer


# Main function is run just before making finalyzing the build process (zip, headers, lang, ...)
def beet_default(ctx: Context) -> None:
	if Mem.ctx is None:
		Mem.ctx = ctx
	generate_other_things()
	generate_books_modifiers()
	generate_pop_ups()
	generate_screamer()

	# Force enable a all modules from Bookshelf (https://docs.mcbookshelf.dev/en/latest/modules/dump.html)
	for module in BOOKSHELF_MODULES.keys():
		official_lib_used(module)

	# Delete quick actions (manual)
	del Mem.ctx.data["minecraft"].dialogs_tags["quick_actions"]

