# Imports
from stewbeet import Mem, write_function

from user.modes.all_together import generate_crew_mode
from user.modes.all_together.phases import CrewMode, Phase

from .shared import LAB, ON_START_PAD, SOLO, START_RADIUS

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
	start_filter=f"distance=..{START_RADIUS},{ON_START_PAD}",
	solo_flag=SOLO,
)
""" Four players split into two pairs, each pair sharing one mannequin that wears the skin of its Joueur 1.
Sprint and crawl sit on different slots since crawl is read on the sprint key.
"""


# Functions
def main() -> None:
	""" Write the duo trial: the crew mode itself, and the reward of its exit. """
	ns: str = Mem.ctx.project_id
	generate_crew_mode(DUO)

	write_function(f"{ns}:{DUO.path}/here/reward", f"""
# One shot at the exit, once the redstone puzzle is solved: the nearest player gets the star
execute as @p[distance=..5,gamemode=!spectator] run function {ns}:{LAB}/give_star {{trial:"Les duos"}}
""")

