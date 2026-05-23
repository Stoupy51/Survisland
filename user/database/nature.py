
# Imports
from stewbeet import Item


# Main function
def main() -> None:

	Item(
		id="maple_leaf",
		components={
			"item_name": {"text":"Feuille d'érable","italic":False,"color":"gold"},
			"max_stack_size": 64
		}
	)

	Item(
		id="golden_leaf",
		components={
			"item_name": {"text":"Feuille d'or","italic":False,"color":"gold"},
			"max_stack_size": 64
		}
	)

