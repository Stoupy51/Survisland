# ruff: noqa: E501
# Imports
from stewbeet import Advancement, JsonDict, Mem, set_json_encoder, write_function

from .shared import LAB, STAR_ITEM, STARS_NEEDED

# Constants
PROFILE: str = "Maarcouscous"
""" Player whose head the villager wears. """

PROFILE_SNBT: str = r'{id:[I;-2040882918,-788446949,-1259858514,297369748],name:"Maarcouscous",properties:[{name:"textures",signature:"bS4xBEhwLaTBjgYaG90BlXMcSELmlqEuzrFcHF8C4xzZYks9rkjms896tZq+jPpJZt7Z0L7au9nAA6UrlFRaRJ/G2uwCeQRS8M3k+6W5RfCyY0OhFCcc/EmCGBJOwfnM+Ib6fa9RJbs3tQ38moWAaGYP3e+o758AR0/oLt7UIdhoz5+UZdpzlCWLet6ptxY9Gxz5xzdmQB/qLNELK2kPr6KBUWcxDVRXv5oLYL2ZGhlBAfLS+KeHgQ1Qo8K/fIHPc6cjGIsKPmManj0ZO84Hhdl1LEI5SB0RkQ0+N32JGpisaLxEY7AGu5ocX+Dmc9Q4GJCQg/oZhpHcAIqqydcdKRqDVVOHPC5c0d6xLilvtlZm8VW9PIQTfC21RBanW1mUVMmyXF+raGDv1TVgmv++c/POA2WHcWYiz5MJKnWXbmBs9eyE30z2t7bjSpXECcl7Av5+W7TlaVrFIx4xQhXs3sCF+XilrmQLLtZsz5w2SrTKc28TkV6+R3Rj1Ob6Ix3q766m8XXAlTe8LOdQZ4Plw1J9jNhzRqWhAEwt/i2rOLeWHzcvbEU84mDsph6ew1Wes3Ts+6YbeTuoWVN8v8sbGdhjPErzipJWJg+QIA9SbN7LvASii/wa0oSqCUomvRO1AXGNbO9k94D2SRfK3m9o9uWKqMqsHYQis4dkTPEr3os=",value:"ewogICJ0aW1lc3RhbXAiIDogMTc5MTAzMTkyMDgxNSwKICAicHJvZmlsZUlkIiA6ICI4NjVhOTkxYWQxMDE0MTFiYjRlODE1YWUxMWI5ODA5NCIsCiAgInByb2ZpbGVOYW1lIiA6ICJNYWFyY291c2NvdXMiLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYjYzNmJmOTRkNTgzMzYwMzc0ZTlhNDA4ZTM1OWJhY2RjMTRjZTdlNzMwNTRmYTNjOGI3NmM1NDU3N2NhZDRkOSIKICAgIH0KICB9Cn0="}]}'
""" Resolved profile of PROFILE with its skin texture, so the head renders without waiting for a Mojang lookup that can fail. """

LAB_RADIUS: int = 100
""" Radius around the player talking to the villager in which the players holding a star are named. """


# Functions
def main() -> None:
	""" Write the villager placement and the star delivery triggered by a click on it, a nitwit so the click never opens trades. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/villager"
	tag: str = f"{ns}.pr_stoupy.villager"

	write_function(f"{root}/here/place", f"""
# Replace any villager of the lab spawned here, facing the rotation of the caller, then free to wander off and be found again
kill @e[tag={tag},distance=..2]
summon minecraft:marker ~ ~ ~ {{Tags:["{tag}","{tag}.spawn"]}}
summon minecraft:villager ~ ~ ~ {{Tags:["{tag}"],Invulnerable:1b,Silent:1b,PersistenceRequired:1b,CustomName:"{PROFILE}",CustomNameVisible:1b,VillagerData:{{profession:"minecraft:nitwit",level:1,type:"minecraft:plains"}},equipment:{{head:{{id:"minecraft:player_head",count:1,components:{{"minecraft:profile":{PROFILE_SNBT}}}}}}},drop_chances:{{head:0.0f}}}}
execute as @n[type=villager,tag={tag},distance=..1] run rotate @s ~ 0
""")

	write_function(f"{root}/talk", f"""
advancement revoke @s only {ns}:{LAB}/villager_click

execute store result score #pr_stoupy_stars {ns}.data run clear @s {STAR_ITEM} 0
execute if score #pr_stoupy_stars {ns}.data matches {STARS_NEEDED}.. run return run function {root}/deliver

scoreboard players set #pr_stoupy_missing {ns}.data {STARS_NEEDED}
scoreboard players operation #pr_stoupy_missing {ns}.data -= #pr_stoupy_stars {ns}.data
tellraw @s ["",{{"text":"<{PROFILE}> ","color":"yellow"}},{{"text":"Rapporte-moi les {STARS_NEEDED} étoiles bleues du laboratoire, toutes ensemble ! Il t'en manque encore "}},{{"score":{{"name":"#pr_stoupy_missing","objective":"{ns}.data"}},"color":"aqua"}},{{"text":"."}}]
scoreboard objectives add {tag}.stars dummy
execute as @a[distance=..{LAB_RADIUS}] store result score @s {tag}.stars run clear @s {STAR_ITEM} 0
execute unless entity @a[distance=..{LAB_RADIUS},scores={{{tag}.stars=1..}}] run tellraw @s ["",{{"text":"<{PROFILE}> ","color":"yellow"}},{{"text":"Personne dans le laboratoire n'a encore d'étoile."}}]
execute if entity @a[distance=..{LAB_RADIUS},scores={{{tag}.stars=1..}}] run tellraw @s ["",{{"text":"<{PROFILE}> ","color":"yellow"}},{{"text":"Déjà des étoiles sur eux : "}},{{"selector":"@a[distance=..{LAB_RADIUS},scores={{{tag}.stars=1..}}]","color":"aqua"}},{{"text":"."}}]
playsound minecraft:entity.villager.no neutral @s
""")

	write_function(f"{root}/deliver", f"""
# The end messages belong to command blocks powered by the redstone block, 2 blocks under the spawn of the villager
clear @s {STAR_ITEM}
execute at @n[type=marker,tag={tag}.spawn] run setblock ~ ~-2 ~ minecraft:redstone_block
""")

	json_content: JsonDict = {
		"criteria": {"requirement": {"trigger": "minecraft:player_interacted_with_entity", "conditions": {"entity": [
			{"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"entity_type": "minecraft:villager", "entity_tags": {"all_of": [tag]}}}
		]}}},
		"rewards": {"function": f"{root}/talk"},
	}
	Mem.ctx.data[ns].advancements[f"{LAB}/villager_click"] = set_json_encoder(Advancement(json_content), max_level=-1)

