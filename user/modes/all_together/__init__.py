
""" Mode "All Together" : quatre joueurs se partagent les commandes d'un seul mannequin.

Chaque joueur est invisible et collé aux yeux du mannequin.
Le mannequin est aussi l'ancre de son groupe : il porte l'état de sa partie dans ses propres scores et
ses joueurs sont ceux à moins de GROUP_RADIUS (50) blocs, donc autant de groupes que voulu tournent en même temps.

# En jeu
Lance le start une fois par zone/team, depuis un endroit situé à moins de GROUP_RADIUS blocs de ses joueurs :

	/function survisland:modes/all_together/start

Il groupe les quatre joueurs les plus proches (gamemode=!creative,gamemode=!spectator),
dans l'ordre de leur distance (le plus proche devient le Joueur 1), puis invoque leur mannequin sur ce Joueur 1.

Tout se repère par rapport au point d'exécution, donc depuis un command block c'est le bloc lui même qui
sert de repère : pose le à portée du groupe, ou vise la zone depuis n'importe où avec un positioned :

	/execute positioned 1250 64 -300 run function survisland:modes/all_together/start

Toutes les autres commandes existent en deux versions, "here/" pour le groupe dont le mannequin est le
plus proche (à moins de ADMIN_RADIUS blocs du point d'exécution),
et la version simple pour tous les groupes d'un coup :

	/function survisland:modes/all_together/here/next_phase          passe ce groupe à la partie suivante
	/function survisland:modes/all_together/here/set_phase/riviere   saute directement à une partie donnée
	/function survisland:modes/all_together/here/shuffle_slots       décalage P1->P2, P2->P3, etc
	/function survisland:modes/all_together/here/stop                rend leur corps aux joueurs de ce groupe
	/function survisland:modes/all_together/stop                     arrête tout, partout

# Dans le code
Tout le reste vit dans phases.py : PHASES contient le set de commandes de chaque partie
(le seul endroit à éditer pour changer qui contrôle quoi), et les constantes juste à côté tiennent les rayons,
les vitesses et la touche utilisée pour allonger le mannequin.
"""
# Imports
from stewbeet import JsonDict, Mem, Predicate, set_json_encoder, write_function

from .controls import attribute_lines, generate_body_tick, generate_dispatchers, generate_phase_functions, generate_tick
from .phases import (
	ACTIONS,
	BACK_SPEED,
	GROUP_RADIUS,
	INPUT_KEYS,
	MANNEQUIN_PROFILE,
	MODE,
	PHASES,
	SNEAK_SPEED,
	SPRINT_SPEED,
	WALK_SPEED,
)


# Functions
def state_objectives() -> list[str]:
	""" List the objectives holding the state of a group, all of them carried by its own mannequin

	Returns:
		list[str]: The objective names, the first one being the player slot objective

	Examples:
		>>> state_objectives()[0].endswith("all_together")
		True
	"""
	ns: str = Mem.ctx.project_id
	return [f"{ns}.{MODE}"] + [f"{ns}.{MODE}.{name}" for name in ("phase", "pose", "sprint")]


def generate_player_helpers() -> None:
	""" Write the per player passes shared by the start and the stop, each one running on a free @s. """
	ns: str = Mem.ctx.project_id
	tag: str = f"{ns}.{MODE}"
	clear_tags: str = "\n".join(f"tag @s remove {tag}.{action.name}" for action in ACTIONS)
	resets: dict[str, str] = dict.fromkeys(("scale", "gravity", "fall_damage_multiplier", "entity_interaction_range", "block_interaction_range"), "reset")

	write_function(f"{ns}:modes/{MODE}/body/clear_player", f"""
{clear_tags}
tag @s remove {tag}
""")

	write_function(f"{ns}:modes/{MODE}/body/release_player", f"""
# Give this player its own body back
gamemode survival @s
effect clear @s minecraft:invisibility
effect clear @s minecraft:resistance
{attribute_lines(resets)}

function {ns}:modes/{MODE}/body/clear_player
""")

	write_function(f"{ns}:modes/{MODE}/body/setup_player", """
# Turn this player into an invisible sensor (scale is clamped to 0.0625 by vanilla, 0 is impossible)
gamemode adventure @s
effect give @s minecraft:invisibility infinite 255 true
effect give @s minecraft:resistance infinite 255 true
attribute @s minecraft:scale base set 0.0625
attribute @s minecraft:gravity base set 0
attribute @s minecraft:fall_damage_multiplier base set 0
""")


def generate_input_predicates() -> None:
	""" Write one predicate per readable key, matching a player currently holding it down. """
	ns: str = Mem.ctx.project_id
	for key in INPUT_KEYS:
		json_content: JsonDict = {"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"minecraft:type_specific/player": {"input": {key: True}}}}
		Mem.ctx.data[ns].predicates[f"input/{key}"] = set_json_encoder(Predicate(json_content), max_level=-1)


def generate_start() -> None:
	""" Write the function starting one group, to be run once inside each zone. """
	ns: str = Mem.ctx.project_id
	tag: str = f"{ns}.{MODE}"
	objectives: str = "\n".join(f"scoreboard objectives add {name} dummy" for name in state_objectives())
	profile: str = f',profile:"{MANNEQUIN_PROFILE}"' if MANNEQUIN_PROFILE else ""

	write_function(f"{ns}:modes/{MODE}/start", f"""
tellraw @a[distance=..{GROUP_RADIUS}] ["\\n",{{"nbt":"Survisland","storage":"{ns}:main","interpret":true}},{{"text":" Vous ne faites plus qu'un ! Chacun n'a qu'une partie des commandes."}}]

# Objectives of the mode, the last four are carried by the mannequins themselves
{objectives}

# Speeds shared by every group, in thousandths of a block per tick
scoreboard players set #{MODE}_speed_walk {ns}.data {WALK_SPEED}
scoreboard players set #{MODE}_speed_sprint {ns}.data {SPRINT_SPEED}
scoreboard players set #{MODE}_speed_back {ns}.data {BACK_SPEED}
scoreboard players set #{MODE}_speed_sneak {ns}.data {SNEAK_SPEED}

# A group may already be running here, it is properly stopped before being replaced
execute as @e[type=mannequin,tag={tag}.body,distance=..{GROUP_RADIUS}] at @s run function {ns}:modes/{MODE}/body/stop
function {ns}:modes/{MODE}/body/clear_group

# The four nearest players become the controllers of this zone
scoreboard players set #{MODE}_slot {ns}.data 0
execute as @a[distance=..{GROUP_RADIUS},gamemode=!creative,gamemode=!spectator,limit=4,sort=nearest] run function {ns}:modes/{MODE}/body/enroll_player

# Their body is summoned on the first of them, never on the caller which may be a command block inside a wall
execute at @a[tag={tag},scores={{{tag}=1}},distance=..{GROUP_RADIUS}] summon minecraft:mannequin run function {ns}:modes/{MODE}/body/new

schedule function {ns}:modes/{MODE}/tick 1t replace
""")

	write_function(f"{ns}:modes/{MODE}/body/new", f"""
# Identity and state of this body
tag @s add {tag}.body
data merge entity @s {{immovable:0b,hide_description:1b,Invulnerable:1b{profile}}}
scoreboard players set @s {tag}.phase 0
scoreboard players set @s {tag}.pose 0

execute at @s run function {ns}:modes/{MODE}/body/setup_sensors
""")

	write_function(f"{ns}:modes/{MODE}/body/setup_sensors", f"""
# Single scan of the group: every player becomes an invisible sensor
execute as @a[tag={tag},distance=..{GROUP_RADIUS}] run function {ns}:modes/{MODE}/body/setup_player

function {ns}:modes/{MODE}/body/set_phase/{PHASES[0].id}
""")

	write_function(f"{ns}:modes/{MODE}/body/enroll_player", f"""
scoreboard players add #{MODE}_slot {ns}.data 1
scoreboard players operation @s {tag} = #{MODE}_slot {ns}.data
tag @s add {tag}
""")

	write_function(f"{ns}:modes/{MODE}/body/clear_group", f"""
# Single scan around here: nobody keeps a tag of the mode, even a leftover one
execute as @a[distance=..{GROUP_RADIUS}] run function {ns}:modes/{MODE}/body/clear_player
""")


def generate_stop() -> None:
	""" Write the function stopping every group, and the one stopping a single body. """
	ns: str = Mem.ctx.project_id
	tag: str = f"{ns}.{MODE}"
	removals: str = "\n".join(f"scoreboard objectives remove {name}" for name in state_objectives())

	write_function(f"{ns}:modes/{MODE}/body/stop", f"""
# Single scan of the group: every player is released, tags included
execute as @a[tag={tag},distance=..{GROUP_RADIUS}] run function {ns}:modes/{MODE}/body/release_player
kill @s
""")

	write_function(f"{ns}:modes/{MODE}/here/stop", f"""
# Only the group whose mannequin is the nearest one
execute as @n[type=mannequin,tag={tag}.body,distance=..{GROUP_RADIUS}] at @s run function {ns}:modes/{MODE}/body/stop
""")

	write_function(f"{ns}:modes/{MODE}/stop", f"""
# Stop every group still running
execute as @e[type=mannequin,tag={tag}.body] at @s run function {ns}:modes/{MODE}/body/stop
kill @e[type=mannequin,tag={tag}.body]

# Catch anyone who ended up out of range of their body
execute as @a[tag={tag}] run function {ns}:modes/{MODE}/body/release_player

{removals}
schedule clear {ns}:modes/{MODE}/tick
""")


def main() -> None:
	""" Generate every file of the "All Together" mode. """
	generate_input_predicates()
	generate_player_helpers()
	generate_start()
	generate_tick()
	generate_body_tick()
	generate_phase_functions()
	generate_dispatchers()
	generate_stop()

