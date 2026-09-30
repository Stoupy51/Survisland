# ruff: noqa: E501
# Imports
from dataclasses import dataclass

from beet import BlockTag
from stewbeet import Mem, set_json_encoder


# Classes
@dataclass(frozen=True)
class BrickColor:
	""" One dye color a player can stand on, with the blocks counting as its bricks. """
	name: str
	""" Dye name, prefix of every block of the color (ex: "light_blue"). """

	@property
	def blocks(self) -> list[str]:
		""" Blocks of this color that count as bricks, and of which the bumper is made (the first one). """
		return [f"minecraft:{self.name}_{kind}" for kind in BRICK_SOUNDS]


# Constants
BRICK_SOUNDS: dict[str, str] = {
	"concrete":      "minecraft:block.stone.break",
	"wool":          "minecraft:block.wool.break",
	"terracotta":    "minecraft:block.stone.break",
	"stained_glass": "minecraft:block.glass.break",
}
""" Block kinds a brick of each color can be made of, the first one being the bumper, with the sound of their break. """

COLORS: list[BrickColor] = [
	BrickColor(name="white"),
	BrickColor(name="orange"),
	BrickColor(name="magenta"),
	BrickColor(name="light_blue"),
	BrickColor(name="yellow"),
	BrickColor(name="lime"),
	BrickColor(name="pink"),
	BrickColor(name="gray"),
	BrickColor(name="light_gray"),
	BrickColor(name="cyan"),
	BrickColor(name="purple"),
	BrickColor(name="blue"),
	BrickColor(name="brown"),
	BrickColor(name="green"),
	BrickColor(name="red"),
	BrickColor(name="black"),
]
""" Every color, its index in this list being the color score of players and balls. """

MULTIBALL: BrickColor = next(color for color in COLORS if color.name == "purple")
""" Color of the bricks any ball breaks to multiply every ball in play, never a player color nor a brick to clear. """

SOLO_COLORS: list[BrickColor] = [color for name in ("red", "light_blue", "lime", "yellow") for color in COLORS if color.name == name]
""" Colors to clear in a game started with fewer players than needed, and of the example booths from the start of the field to its end. """


# Functions
def color_tag(color: BrickColor) -> str:
	""" Block tag of the bricks of a color

	>>> color_tag(COLORS[14])
	'#survisland:pr_stoupy/breakout/red'
	"""
	return f"#survisland:pr_stoupy/breakout/{color.name}"


def generate_color_tags() -> None:
	""" Write one block tag per color, their union and one per block kind. """
	ns: str = Mem.ctx.project_id
	for color in COLORS:
		Mem.ctx.data[ns].block_tags[f"pr_stoupy/breakout/{color.name}"] = set_json_encoder(BlockTag({"values": color.blocks}))
	Mem.ctx.data[ns].block_tags["pr_stoupy/breakout/any"] = set_json_encoder(BlockTag({"values": [color_tag(color) for color in COLORS]}))
	for kind in BRICK_SOUNDS:
		Mem.ctx.data[ns].block_tags[f"pr_stoupy/breakout/{kind}"] = set_json_encoder(BlockTag({"values": [f"minecraft:{color.name}_{kind}" for color in COLORS]}))

