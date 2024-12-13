
# Imports
from user.utils.other import main as generate_other_things
from user.utils.item_modifiers import main as generate_books_modifiers
from user.utils.pop_ups import main as generate_pop_ups
from user.utils.screamer import main as generate_screamer

# Main function is run just before making finalyzing the build process (zip, headers, lang, ...)
def main(config: dict) -> None:
	generate_other_things(config)
	generate_books_modifiers(config)
	generate_pop_ups(config)
	generate_screamer(config)
	pass

