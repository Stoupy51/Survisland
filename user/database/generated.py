
# Imports
import os

from stewbeet import Item, Mem, Painting, PaintingData


# Main function
def main() -> None:
	ns: str = Mem.ctx.project_id

	# Get textures
	textures_folder = str(Mem.ctx.meta.get("stewbeet", {}).get("textures_folder", ""))
	textures: list[str] = [os.path.splitext(file)[0] for _, _, files in os.walk(textures_folder) for file in files if file.endswith(".png")]

	# Add colored books
	books: list[str] = [x for x in textures if "book_" in x]
	for book in books:
		Item(id=book, base_item="minecraft:written_book", manual_category="book")

	# Add edible colored fishs
	fishs: list[str] = [x for x in textures if "poisson_" in x]
	for fish in fishs:
		Item(
			id=fish,
			base_item="minecraft:apple",
			manual_category="fish",
			components={
				"consumable": {},
				"food": {"nutrition": 4, "saturation": 2.4, "can_always_eat": True},
				"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
				"equippable": {"slot": "head", "camera_overlay":f"{ns}:item/{fish}"}
			}
		)

	# Add edible logos
	for logo in textures:
		if "logo_" in logo:
			Item(
				id=logo,
				base_item="minecraft:apple",
				manual_category="logo",
				components={
					"consumable": {},
					"food": {"nutrition": 4, "saturation": 2.4, "can_always_eat": True}
				}
			)

	# Add blockguessr items
	for item in [x for x in textures if "blockguessr_" in x]:
		if "_map" in item:
			Item(id="blockguessr_map", base_item="minecraft:carrot_on_a_stick", override_model={"parent":"item/generated"})
			continue

	# Add smolder shader textures
	for item in [x for x in textures if "smolder_" in x]:
		Item(id=item, override_model={"parent":"minecraft:block/cube_all"})

	# Add paintings
	for item in ("mariage_painting", "knights_painting", "koko_painting", "fusoya_painting", "hamelin_painting"):
		Painting(id=item, painting_data=PaintingData(
			texture=f"painting/{item}",
			author={"text":"Tata_Mymy","color":"yellow"},
			width=4,
			height=4
		))

