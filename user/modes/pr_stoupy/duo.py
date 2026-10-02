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
	SEND_BACK,
	SOLO,
	START_RADIUS,
	STORE_TP,
	TELEPORT,
)

# Constants
DUO: CrewMode = CrewMode(
	id="pr_stoupy_duo",
	path=f"{LAB}/duo",
	group_size=2,
	start_players=4,
	phases=[
		Phase(id="laboratoire", display="Laboratoire - Duo", bindings={
			"look": (1,), "forward": (1,), "backward": (1,), "sprint": (1,),
			"click": (2,), "left": (2,), "right": (2,), "jump": (2,), "sneak": (2,), "crawl": (2,),
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
	""" Write the duo trial: the crew mode with its start teleport and its way back, and the reward of its exit. """
	ns: str = Mem.ctx.project_id
	lock: str = f"{ns}.{DUO.id}.done"
	generate_crew_mode(DUO)
	write_function(f"{ns}:{DUO.path}/start", f"""
{FORGET_BACK}
execute if entity @e[type=minecraft:marker,tag={lock},distance=..{START_RADIUS}] run return 0
# $(tp) moves each player of a new pair from where it stands, "" to leave them on the pads
{STORE_TP}
""", prepend=True)
	write_function(f"{ns}:{DUO.path}/body/release_player", SEND_BACK)

	write_function(f"{ns}:{DUO.path}/here/reward", f"""
# One shot at the exit, once the redstone puzzle is solved: the nearest player gets the star
execute as @p[distance=..5,gamemode=!spectator] run function {ns}:{LAB}/give_star {{trial:"Les duos"}}
execute if entity @p[distance=..5,gamemode=!spectator] summon minecraft:marker run function {ns}:{DUO.path}/lock
""")

	write_function(f"{ns}:{DUO.path}/lock", f"""
# Run at the reward block, so @p is the winner: the marker goes where its start took it from and locks that start until here/clear
tag @s add {lock}
{"\n".join(f"execute store result entity @s Pos[{index}] double 0.01 run scoreboard players get @p[gamemode=!spectator] {ns}.pr_stoupy.{axis}" for index, axis in enumerate("xyz"))}
""")

