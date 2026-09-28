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
	display: str
	""" How the players call it, used in "Joueur <display> est mort". """
	team_color: str
	""" Chat color of the team giving its glow to the ball. """

	@property
	def blocks(self) -> list[str]:
		""" Blocks of this color that count as bricks, and of which the bumper is made (the first one). """
		return [f"minecraft:{self.name}_{kind}" for kind in ("concrete", "wool", "terracotta", "stained_glass")]


# Constants
COLORS: list[BrickColor] = [
	BrickColor(name="white",      display="blanc",      team_color="white"),
	BrickColor(name="orange",     display="orange",     team_color="gold"),
	BrickColor(name="magenta",    display="magenta",    team_color="light_purple"),
	BrickColor(name="light_blue", display="bleu clair", team_color="aqua"),
	BrickColor(name="yellow",     display="jaune",      team_color="yellow"),
	BrickColor(name="lime",       display="vert clair", team_color="green"),
	BrickColor(name="pink",       display="rose",       team_color="light_purple"),
	BrickColor(name="gray",       display="gris",       team_color="dark_gray"),
	BrickColor(name="light_gray", display="gris clair", team_color="gray"),
	BrickColor(name="cyan",       display="cyan",       team_color="dark_aqua"),
	BrickColor(name="purple",     display="violet",     team_color="dark_purple"),
	BrickColor(name="blue",       display="bleu",       team_color="blue"),
	BrickColor(name="brown",      display="marron",     team_color="gold"),
	BrickColor(name="green",      display="vert",       team_color="dark_green"),
	BrickColor(name="red",        display="rouge",      team_color="red"),
	BrickColor(name="black",      display="noir",       team_color="black"),
]
""" Every color, its index in this list being the color score of players and balls. """

SOLO_COLORS: list[BrickColor] = [color for name in ("red", "light_blue", "lime", "yellow") for color in COLORS if color.name == name]
""" Colors broken by every ball of a game started with fewer players than needed, and of the example booths from the start of the field to its end. """


# Functions
def color_tag(color: BrickColor) -> str:
	""" Block tag of the bricks of a color

	>>> color_tag(COLORS[14])
	'#survisland:pr_stoupy/breakout/red'
	"""
	return f"#survisland:pr_stoupy/breakout/{color.name}"


def generate_color_tags() -> None:
	""" Write one block tag per color, their union, the concretes taking two hits and the solo colors. """
	ns: str = Mem.ctx.project_id
	for color in COLORS:
		Mem.ctx.data[ns].block_tags[f"pr_stoupy/breakout/{color.name}"] = set_json_encoder(BlockTag({"values": color.blocks}))
	Mem.ctx.data[ns].block_tags["pr_stoupy/breakout/any"] = set_json_encoder(BlockTag({"values": [color_tag(color) for color in COLORS]}))
	Mem.ctx.data[ns].block_tags["pr_stoupy/breakout/concrete"] = set_json_encoder(BlockTag({"values": [f"minecraft:{color.name}_concrete" for color in COLORS]}))
	Mem.ctx.data[ns].block_tags["pr_stoupy/breakout/solo"] = set_json_encoder(BlockTag({"values": [color_tag(color) for color in SOLO_COLORS]}))


def team_name(color: BrickColor) -> str:
	""" Team giving its glow color to the balls of a color

	>>> team_name(COLORS[14])
	'survisland.breakout.red'
	"""
	return f"survisland.breakout.{color.name}"


def team_setup_lines() -> str:
	""" Commands creating one team per color: the glow of a ball takes its color, and balls never push each other. """
	return "\n".join(
		f"team add {team_name(color)}\nteam modify {team_name(color)} color {color.team_color}\nteam modify {team_name(color)} collisionRule never"
		for color in COLORS
	)

