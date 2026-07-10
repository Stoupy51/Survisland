
# ruff: noqa: E501
# Imports
from stewbeet import Mem, write_function


# Generates the url tellraw function
def main() -> None:
	ns: str = Mem.ctx.project_id

	# utils/url
	write_function(f"{ns}:utils/url", """
# Playsound to everyone
execute as @a at @s run playsound entity.experience_orb.pickup ambient @s

# Tellraw with link
$tellraw @a ["\\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lien vers la vidéo d'explication [clique ici]","color":"yellow","click_event":{"action":"open_url","url":"$(url)"},"hover_event":{"action":"show_text","value":"Oui ici !"}}]
""")

