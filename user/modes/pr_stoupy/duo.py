# ruff: noqa: E501
# Imports
from stewbeet import Mem, write_function

from user.modes.all_together import generate_crew_mode
from user.modes.all_together.phases import CrewMode, Phase

from .shared import (
	BACK,
	FORGET_BACK,
	LAB,
	ON_START_PAD,
	REWARD_RADIUS,
	SEND_BACK,
	SOLO,
	START_RADIUS,
	STORE_TP,
	TELEPORT,
	write_match_predicate,
)

# Constants
DUO: CrewMode = CrewMode(
	id="pr_stoupy_duo",
	path=f"{LAB}/duo",
	group_size=2,
	start_players=4,
	phases=[
		Phase(id="laboratoire", display="Laboratoire - Duo", bindings={
			"look": (1,), "forward": (1,), "backward": (1,),
			"click": (2,), "left": (2,), "right": (2,), "jump": (2,), "crawl": (2,),
		}),
	],
	profile="",
	start_filter=f"tag=!{BACK},distance=..{START_RADIUS},{ON_START_PAD}",
	solo_flag=SOLO,
	camera_distance=7,
	enroll_command=TELEPORT,
)
""" Four players split into two pairs, each pair sharing one mannequin that wears the skin of its Joueur 1.
Sprint and crawl sit on different slots since crawl is read on the sprint key.
"""


# Functions
def main() -> None:
	""" Write the duo trial: the crew mode with its start teleport and its way back, and the reward ending the game of a room. """
	ns: str = Mem.ctx.project_id
	tag: str = f"{ns}.{DUO.id}"
	lock: str = f"{tag}.done"
	same_room: str = write_match_predicate(f"{DUO.path}/same_room", {f"{tag}.room": f"#{DUO.id}_room"})
	generate_crew_mode(DUO)
	write_function(f"{ns}:{DUO.path}/start", f"""
{FORGET_BACK}
execute if entity @e[type=minecraft:marker,tag={lock},distance=..{START_RADIUS}] run return 0
# $(tp) moves each player of a new pair from where it stands, "" to leave them on the pads
{STORE_TP}

# The pairs formed by this start share a room, named after the first group they open
scoreboard objectives add {tag}.room dummy
scoreboard players add #{DUO.id}_group_counter {ns}.data 0
scoreboard players operation #{DUO.id}_room {ns}.data = #{DUO.id}_group_counter {ns}.data
scoreboard players add #{DUO.id}_room {ns}.data 1
""", prepend=True)
	room: str = f"scoreboard players operation @s {tag}.room = #{DUO.id}_room {ns}.data"
	write_function(f"{ns}:{DUO.path}/body/enroll_player", room)
	write_function(f"{ns}:{DUO.path}/body/new", room)
	write_function(f"{ns}:{DUO.path}/body/release_player", SEND_BACK)

	write_function(f"{ns}:{DUO.path}/here/reward", f"""
# The room of the nearest mannequin, so nothing happens once it is over: its nearest player gets the star and locks its start,
# then every pair of the room gets its body back on its start pad
execute unless entity @e[type=mannequin,tag={tag}.body,distance=..{REWARD_RADIUS}] run return 0
scoreboard players operation #{DUO.id}_room {ns}.data = @n[type=mannequin,tag={tag}.body,distance=..{REWARD_RADIUS}] {tag}.room
execute as @p[tag={tag},{same_room}] at @s run function {ns}:{LAB}/give_star {{trial:"Les duos"}}
execute summon minecraft:marker run function {ns}:{DUO.path}/lock
execute as @e[type=mannequin,tag={tag}.body,{same_room}] at @s run function {ns}:{DUO.path}/body/stop
""")

	write_function(f"{ns}:{DUO.path}/lock", f"""
# Moved where the start took the winner from, which locks that start until here/clear
tag @s add {lock}
{"\n".join(f"execute store result entity @s Pos[{index}] double 0.01 run scoreboard players get @p[tag={tag},{same_room}] {ns}.pr_stoupy.{axis}" for index, axis in enumerate("xyz"))}
""")

