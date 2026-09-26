# ruff: noqa: E501
# Imports
import json

from stewbeet import Mem, write_function

# Constants
LAB: str = "modes/pr_stoupy"
""" Function folder of the lab, every trial lives in a subfolder of it. """

STAR_ITEM: str = "*[custom_data~{survisland:{blue_star:true}}]"
""" Item predicate matching a blue star, for clear and count commands. """

STARS_NEEDED: int = 5
""" Blue stars the villager asks for, one per trial. """

CRT_COLOR: str = "#01FE41"
""" Text color turned into an old CRT screen by the text shader, the exact value is the trigger. """


# Functions
def crt_text(text: str) -> str:
	""" Build a JSON text component drawn by the CRT shader

	>>> crt_text("5")
	'{"text": "5", "color": "#01FE41"}'
	"""
	return json.dumps({"text": text, "color": CRT_COLOR}, ensure_ascii=False)


def generate_give_star() -> None:
	""" Write the function giving the blue star of a trial to @s, announced to everyone around. """
	ns: str = Mem.ctx.project_id

	write_function(f"{ns}:{LAB}/give_star", f"""
# @s receives the star of the trial named $(trial)
loot give @s loot {ns}:i/blue_star
$tellraw @a[distance=..48] ["\\n",{{"nbt":"Survisland","storage":"{ns}:main","interpret":true}},{{"text":" Épreuve \\"$(trial)\\" réussie ! ","color":"green"}},{{"selector":"@s","color":"aqua"}},{{"text":" récupère une étoile bleue.","color":"green"}}]
title @a[distance=..48] times 10 50 20
$title @a[distance=..48] subtitle {{"text":"$(trial)","color":"aqua"}}
title @a[distance=..48] title {{"text":"Étoile bleue obtenue !","color":"gold"}}
playsound minecraft:ui.toast.challenge_complete master @a[distance=..48]
""")

