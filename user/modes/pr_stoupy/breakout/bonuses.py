""" Bonuses of the breakout, given in turn to the ball breaking every BONUS_BRICKS-th brick of a game, and the multiball of the multiball bricks. """
# ruff: noqa: E501
# Imports
import json
from dataclasses import dataclass

from stewbeet import McFunction, Mem, write_function

from ..shared import LAB
from .physics import MODE, ZONE_ANGLES


# Classes
@dataclass(frozen=True)
class Bonus:
	""" One bonus of the cycle, run as the ball that earned it, loaded motion in #pr_breakout_mu and #pr_breakout_mv. """
	name: str
	""" Function name under breakout/bonus/. """
	display: str
	""" Action bar message shown to the players of the arena. """
	commands: McFunction
	""" Body of the function, where {ns}, {root} and {tag} are filled in. """


# Constants
BONUS_BRICKS: int = 15
""" Bricks broken between two bonuses, counted over the whole game. """

BONUSES: list[Bonus] = [
	Bonus(name="speed", display="Bonus : vitesse x1.5 !", commands="""
# Half again as fast until the ball is lost, on top of its previous speed bonuses
scoreboard players operation @s {tag}.speed *= #3 {ns}.data
scoreboard players operation @s {tag}.speed /= #2 {ns}.data
execute if score #pr_breakout_axis {ns}.data matches 0 store result entity @s Motion[0] double 0.0015 run scoreboard players get #pr_breakout_mu {ns}.data
execute if score #pr_breakout_axis {ns}.data matches 1 store result entity @s Motion[2] double 0.0015 run scoreboard players get #pr_breakout_mu {ns}.data
execute store result entity @s Motion[1] double 0.0015 run scoreboard players get #pr_breakout_mv {ns}.data
"""),
	Bonus(name="split", display="Bonus : balles x2 !", commands="""
# A second ball of the same player, launched upward from here at the speed of this one
scoreboard players operation #pr_breakout_slot {ns}.data = @s {tag}
scoreboard players operation #pr_breakout_color {ns}.data = @s {tag}.color
scoreboard players operation #pr_breakout_speed {ns}.data = @s {tag}.speed
execute at @s summon minecraft:sulfur_cube run function {root}/new_ball
"""),
]
""" Bonuses in the order they are given, starting over after the last one. """

MULTIBALL_FACTOR: int = 5
""" Balls each ball in play becomes when a multiball brick breaks. """

MAX_BALLS: int = 40
""" Balls an arena holds at most, the multiball stopping there so a few multiball bricks never flood the server. """


# Functions
def main(players: str, balls: str) -> None:
	""" Write the brick counter, the bonuses it gives in turn, and the multiball of the multiball bricks.

	Args:
		players: Selector of the players of the arena in #pr_breakout_arena
		balls:   Selector of the balls of that arena
	"""
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	give: str = "\n".join(f"execute if score #{MODE}_bonus {ns}.data matches {index} run function {root}/bonus/{bonus.name}" for index, bonus in enumerate(BONUSES))

	write_function(f"{root}/bonus/count", f"""
# @s is the ball that broke a brick
scoreboard players add #{MODE}_broken {ns}.data 1
execute if score #{MODE}_broken {ns}.data matches ..{BONUS_BRICKS - 1} run return 0
scoreboard players set #{MODE}_broken {ns}.data 0
{give}
scoreboard players add #{MODE}_bonus {ns}.data 1
scoreboard players operation #{MODE}_bonus {ns}.data %= #{len(BONUSES)} {ns}.data
""")

	for bonus in BONUSES:
		write_function(f"{root}/bonus/{bonus.name}", bonus.commands.format(ns=ns, root=root, tag=tag) + f"""
title {players} actionbar {json.dumps({"text": bonus.display, "color": "#01FE41"}, ensure_ascii=False)}
execute as {players} at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1.2
""")

	clones: str = "\n".join([f"execute if score #{MODE}_balls {ns}.data matches ..{MAX_BALLS - 1} run function {root}/bonus/clone_ball"] * (MULTIBALL_FACTOR - 1))
	write_function(f"{root}/bonus/multiball", f"""
# Positioned on a multiball brick, which any ball breaks without it counting as a brick of the level
function {root}/shatter
execute store result score #{MODE}_balls {ns}.data if entity {balls}
execute as {balls} at @s run function {root}/bonus/multiply_ball
title {players} actionbar {json.dumps({"text": f"Bonus : balles x{MULTIBALL_FACTOR} !", "color": "#01FE41"}, ensure_ascii=False)}
execute as {players} at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 0.8
""")

	write_function(f"{root}/bonus/multiply_ball", f"""
# @s is a ball in play, its copies share its player, its color and its speed
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
scoreboard players operation #{MODE}_color {ns}.data = @s {tag}.color
scoreboard players operation #{MODE}_speed {ns}.data = @s {tag}.speed
{clones}
""")

	write_function(f"{root}/bonus/clone_ball", f"""
scoreboard players add #{MODE}_balls {ns}.data 1
execute summon minecraft:sulfur_cube run function {root}/bonus/new_clone
""")

	write_function(f"{root}/bonus/new_clone", f"""
# Any slice, up or down, so the copies spread out instead of following the ball they came from
function {root}/new_ball
execute store result score #{MODE}_zone {ns}.data run random value 0..{len(ZONE_ANGLES) - 1}
function {root}/apply_zone
execute store result score #{MODE}_down {ns}.data run random value 0..1
execute if score #{MODE}_down {ns}.data matches 1 store result entity @s Motion[1] double -0.001 run scoreboard players get #{MODE}_mv {ns}.data
execute if score #{MODE}_down {ns}.data matches 1 run scoreboard players operation #{MODE}_mv {ns}.data *= #-1 {ns}.data
scoreboard players operation @s {tag}.mu = #{MODE}_mu {ns}.data
scoreboard players operation @s {tag}.mv = #{MODE}_mv {ns}.data
""")

