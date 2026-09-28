""" Doors of the trial rooms, closed while a player of the trial is around so nobody leaves or comes in during a game.

A door is one block of a doorway: a marker remembering which block fills it and whose players close it.
Each start wakes the door loop, which runs while at least one door is closed, then stops by itself.
"""
# Imports
from dataclasses import dataclass

from stewbeet import Mem, write_function

from .breakout.physics import MODE as BREAKOUT_MODE
from .duo import DUO
from .mirror import MODE as MIRROR_MODE
from .orbit import MODE as ORBIT_MODE
from .shared import LAB


# Classes
@dataclass(frozen=True)
class LockedTrial:
	""" A trial whose room can be closed, recognized by the tag its players wear during a game. """
	path: str
	""" Function folder of the trial, ex: "modes/pr_stoupy/mirror". """
	mode: str
	""" Suffix of the player tag, ex: "pr_mirror" for survisland.pr_mirror. """


# Constants
LOCKED_TRIALS: list[LockedTrial] = [
	LockedTrial(path=DUO.path,           mode=DUO.id),
	LockedTrial(path=f"{LAB}/mirror",    mode=MIRROR_MODE),
	LockedTrial(path=f"{LAB}/breakout",  mode=BREAKOUT_MODE),
	LockedTrial(path=f"{LAB}/orbit",     mode=ORBIT_MODE),
]
""" Trials with a start, the rats having none since anyone may join them at any time. """

DOOR_PERIOD: int = 10
""" Ticks between two checks of the doors while one of them is closed. """

DOOR_TAG: str = "survisland.pr_stoupy.door"
""" Tag of the door markers. """


# Functions
def main() -> None:
	""" Write the door placement of each trial, the loop closing and opening them, and its wake up at every start. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/door"

	for trial in LOCKED_TRIALS:
		write_function(f"{ns}:{trial.path}/here/place_door", f"""
# One block of a doorway, filled with $(block) while a player of the trial is within $(radius) blocks
execute align xyz positioned ~0.5 ~ ~0.5 run kill @e[type=minecraft:marker,tag={DOOR_TAG},distance=..0.5]
$execute align xyz positioned ~0.5 ~ ~0.5 run summon minecraft:marker ~ ~ ~ {{Tags:["{DOOR_TAG}"],data:{{block:"$(block)",player_tag:"{ns}.{trial.mode}",radius:$(radius)}}}}
tellraw @a[distance=..16] {{"text":"Porte placée.","color":"green"}}
""")
		write_function(f"{ns}:{trial.path}/start", f"""
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/tick", f"""
scoreboard players set #pr_stoupy_closed {ns}.data 0
execute as @e[type=minecraft:marker,tag={DOOR_TAG}] at @s run function {root}/update with entity @s data
execute if score #pr_stoupy_closed {ns}.data matches 1.. run schedule function {root}/tick {DOOR_PERIOD}t replace
""")

	write_function(f"{root}/update", f"""
$execute unless entity @a[tag=$(player_tag),distance=..$(radius)] run return run function {root}/open with entity @s data
$setblock ~ ~ ~ $(block)
scoreboard players add #pr_stoupy_closed {ns}.data 1
""")

	write_function(f"{root}/open", """
# Only the door block itself is removed, whatever else was built in the doorway stays
$execute if block ~ ~ ~ $(block) run setblock ~ ~ ~ minecraft:air
""")

