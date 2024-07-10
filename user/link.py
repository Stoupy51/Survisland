
# Imports
from python_datapack.constants import *
from python_datapack.utils.print import *
from python_datapack.utils.io import *

from user.utils.other import main as generate_other_things
from user.utils.item_modifiers import main as generate_books_modifiers

# Main function is run just before making finalyzing the build process (zip, headers, lang, ...)
def main(config: dict) -> None:
	generate_other_things(config)
	generate_books_modifiers(config)
	pass

