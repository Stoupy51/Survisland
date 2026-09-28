""" Bonuses of the breakout, given in turn to the ball breaking every BONUS_BRICKS-th brick of a game. """
# Imports
import json
from dataclasses import dataclass

from stewbeet import McFunction, Mem, write_function

from ..shared import LAB
from .physics import MODE


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


# Functions
def main(players: str) -> None:
	""" Write the brick counter and the bonuses it gives in turn.

	Args:
		players: Selector of the players of the arena in #pr_breakout_arena
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

