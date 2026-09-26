# ruff: noqa: E501
# Imports
from stewbeet import Advancement, JsonDict, Mem, set_json_encoder, write_function

from .shared import LAB, STAR_ITEM, STARS_NEEDED

# Constants
PROFILE: str = "Maarcouscous"
""" Player whose head the villager wears. """


# Functions
def main() -> None:
	""" Write the villager placement and the star delivery triggered by a click on it. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/villager"
	tag: str = f"{ns}.pr_stoupy.villager"

	write_function(f"{root}/here/place", f"""
# Replace any villager of the lab standing here, facing the rotation of the caller
kill @e[tag={tag},distance=..2]
summon minecraft:villager ~ ~ ~ {{Tags:["{tag}"],NoAI:1b,Invulnerable:1b,Silent:1b,PersistenceRequired:1b,CustomName:"{PROFILE}",CustomNameVisible:1b,VillagerData:{{profession:"minecraft:nitwit",level:1,type:"minecraft:plains"}},equipment:{{head:{{id:"minecraft:player_head",count:1,components:{{"minecraft:profile":"{PROFILE}"}}}}}},drop_chances:{{head:0.0f}}}}
execute as @n[type=villager,tag={tag},distance=..1] run rotate @s ~ 0

# The interaction box encloses the villager, so every click lands on it instead of opening the trades
summon minecraft:interaction ~ ~ ~ {{Tags:["{tag}"],width:0.9f,height:2.1f,response:1b}}
""")

	write_function(f"{root}/talk", f"""
advancement revoke @s only {ns}:{LAB}/villager_click
execute as @n[type=interaction,tag={tag},distance=..8] run data remove entity @s interaction

execute store result score #pr_stoupy_stars {ns}.data run clear @s {STAR_ITEM} 0
execute if score #pr_stoupy_stars {ns}.data matches {STARS_NEEDED}.. run return run function {root}/deliver

scoreboard players set #pr_stoupy_missing {ns}.data {STARS_NEEDED}
scoreboard players operation #pr_stoupy_missing {ns}.data -= #pr_stoupy_stars {ns}.data
tellraw @s ["",{{"text":"<{PROFILE}> ","color":"yellow"}},{{"text":"Rapporte-moi les {STARS_NEEDED} étoiles bleues du laboratoire, toutes ensemble ! Il t'en manque encore "}},{{"score":{{"name":"#pr_stoupy_missing","objective":"{ns}.data"}},"color":"aqua"}},{{"text":"."}}]
playsound minecraft:entity.villager.no neutral @s
""")

	write_function(f"{root}/deliver", f"""
clear @s {STAR_ITEM} {STARS_NEEDED}
tellraw @a ["\\n",{{"nbt":"Survisland","storage":"{ns}:main","interpret":true}},{{"text":" "}},{{"selector":"@s","color":"aqua"}},{{"text":" a rapporté les {STARS_NEEDED} étoiles bleues à {PROFILE} : le laboratoire du professeur Stoupy est terminé !","color":"gold"}}]
title @a[distance=..32] times 10 70 20
title @a[distance=..32] subtitle {{"text":"Laboratoire du professeur Stoupy","color":"aqua"}}
title @a[distance=..32] title {{"text":"Épreuve terminée !","color":"gold"}}
playsound minecraft:entity.villager.celebrate neutral @a[distance=..32]
playsound minecraft:ui.toast.challenge_complete master @a[distance=..32]
""")

	json_content: JsonDict = {
		"criteria": {"requirement": {"trigger": "minecraft:player_interacted_with_entity", "conditions": {"entity": [
			{"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"type": "minecraft:interaction", "nbt": f'{{Tags:["{tag}"]}}'}}
		]}}},
		"rewards": {"function": f"{root}/talk"},
	}
	Mem.ctx.data[ns].advancements[f"{LAB}/villager_click"] = set_json_encoder(Advancement(json_content), max_level=-1)

