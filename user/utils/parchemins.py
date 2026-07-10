
# ruff: noqa: E501
# Imports
from stewbeet import Item, Mem, write_function


# Generates parchemins related functions
def main() -> None:
	ns: str = Mem.ctx.project_id

	# parchemins/_convert_to_scroll
	parchemin = Item.from_id("parchemin")
	p_id: str = parchemin.base_item
	p_model: str = parchemin.components["item_model"]
	write_function(f"{ns}:parchemins/_convert_to_scroll", f"""
# Replace the book by a scroll
data modify storage {ns}:main Item.id set value "{p_id}"
data modify storage {ns}:main Item.components."minecraft:item_model" set value "{p_model}"
""")

