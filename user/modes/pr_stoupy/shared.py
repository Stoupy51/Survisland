# ruff: noqa: E501
# Imports
import json

from beet import BlockTag
from stewbeet import JsonDict, Mem, Predicate, set_json_encoder, write_function

# Constants
LAB: str = "modes/pr_stoupy"
""" Function folder of the lab, every trial lives in a subfolder of it. """

STAR_ITEM: str = "*[custom_data~{survisland:{blue_star:true}}]"
""" Item predicate matching a blue star, for clear and count commands. """

STARS_NEEDED: int = 5
""" Blue stars the villager asks for, one per trial. """

CRT_COLOR: str = "#01FE41"
""" Text color turned into an old CRT screen by the text shader, the exact value is the trigger. """

START_RADIUS: int = 16
""" Radius around a start command block in which the players standing on a start pad are taken. """

START_PAD_BLOCKS: list[str] = ["minecraft:emerald_block"]
""" Blocks a player stands on to be taken by a start, gathered in the block tag behind ON_START_PAD. """

ON_START_PAD: str = f"predicate=survisland:{LAB}/on_start_pad"
""" Selector argument true for a player standing on a start pad. """

SOLO: str = "#pr_stoupy_solo survisland.data"
""" Set to 1 by the solo function, every start then runs with a single player. """


# Functions
def crt_text(text: str) -> str:
	""" Build a JSON text component drawn by the CRT shader

	>>> crt_text("5")
	'{"text": "5", "color": "#01FE41"}'
	"""
	return json.dumps({"text": text, "color": CRT_COLOR}, ensure_ascii=False)


def write_match_predicate(path: str, matches: dict[str, str]) -> str:
	""" Write a predicate true when every objective of the entity equals its fake player, and return the selector argument using it

	Args:
		path:    Predicate path inside the project namespace
		matches: Objective -> fake player (read in the data objective) it must be equal to
	Returns:
		The selector argument, ex: "predicate=survisland:modes/pr_stoupy/orbit/same_arena"
	"""
	ns: str = Mem.ctx.project_id
	scores: JsonDict = {}
	for objective, fake in matches.items():
		bound: JsonDict = {"type": "minecraft:score", "target": {"type": "minecraft:fixed", "name": fake}, "score": f"{ns}.data"}
		scores[objective] = {"min": bound, "max": bound}
	Mem.ctx.data[ns].predicates[path] = set_json_encoder(Predicate({"condition": "minecraft:entity_scores", "entity": "this", "scores": scores}), max_level=-1)
	return f"predicate={ns}:{path}"


def require_players(free: str, needed: int) -> str:
	""" Commands leaving the function unless the score counts enough players, a single one in solo mode

	Args:
		free: Score holding the number of players found, ex: "#pr_mirror_free survisland.data"

	>>> print(require_players("#f d", 2))
	execute unless score #f d matches 1.. run return 0
	execute unless score #pr_stoupy_solo survisland.data matches 1 unless score #f d matches 2.. run return 0
	"""
	return f"execute unless score {free} matches 1.. run return 0\nexecute unless score {SOLO} matches 1 unless score {free} matches {needed}.. run return 0"


def generate_lobby() -> None:
	""" Write the start pads and the solo switch shared by every start of the lab. """
	ns: str = Mem.ctx.project_id
	Mem.ctx.data[ns].block_tags["pr_stoupy/start_pad"] = set_json_encoder(BlockTag({"values": START_PAD_BLOCKS}))
	Mem.ctx.data[ns].predicates[f"{LAB}/on_start_pad"] = set_json_encoder(Predicate({"condition": "minecraft:entity_properties", "entity": "this", "predicate": {
		"stepping_on": {"block": {"blocks": f"#{ns}:pr_stoupy/start_pad"}},
	}}), max_level=-1)

	write_function(f"{ns}:{LAB}/solo", f"""
# $(enabled) at 1 lets every trial start with one player, and a duo player then holds every command
$scoreboard players set {SOLO} $(enabled)
execute if score {SOLO} matches 1 run tellraw @s {{"text":"Laboratoire : mode solo activé, chaque trial démarre avec un seul joueur.","color":"yellow"}}
execute unless score {SOLO} matches 1 run tellraw @s {{"text":"Laboratoire : mode solo désactivé.","color":"yellow"}}
""")


def copy_state(mode: str, names: tuple[str, ...], to_anchor: bool) -> str:
	""" Commands copying the state of an arena between its anchor (@s) and the fake players the functions work on

	>>> print(copy_state("pr_x", ("round",), to_anchor=False))
	scoreboard players operation #pr_x_round survisland.data = @s survisland.pr_x.round
	"""
	ns: str = "survisland"
	return "\n".join(
		f"scoreboard players operation @s {ns}.{mode}.{name} = #{mode}_{name} {ns}.data" if to_anchor
		else f"scoreboard players operation #{mode}_{name} {ns}.data = @s {ns}.{mode}.{name}"
		for name in names
	)


def generate_give_star() -> None:
	""" Write the function giving the blue star of a trial to @s, announced to everyone around. """
	ns: str = Mem.ctx.project_id

	write_function(f"{ns}:{LAB}/give_star", f"""
# @s receives the star of the trial named $(trial)
loot give @s loot {ns}:i/blue_star
$tellraw @a[distance=..96] ["\\n",{{"nbt":"Survisland","storage":"{ns}:main","interpret":true}},{{"text":" Expérience '$(trial)' réussie !\\n","color":"green"}},{{"selector":"@a[gamemode=!spectator,distance=..12]","color":"aqua"}},{{"text":" récupère(nt) une étoile bleue.","color":"green"}}]
title @a[distance=..96] times 10 50 20
$title @a[distance=..96] subtitle {{"text":"$(trial)","color":"aqua"}}
title @a[distance=..96] title {{"text":"Étoile bleue obtenue !","color":"gold"}}
execute as @a[distance=..96] at @s run playsound entity.player.levelup ambient @s ~ ~ ~ 0.5 0
""")

