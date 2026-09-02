
""" Mode "All Together" : quatre joueurs se partagent les commandes d'un seul mannequin.

Chaque joueur est invisible et monté sur la tête du mannequin, sauf celui qui clique, assis sur un item display
invisible juste devant son visage pour avoir le monde à portée de main.
Tout le monde sauf le joueur "look" a sa rotation forcée sur la sienne, donc le groupe voit la même chose.
Le mannequin est l'ancre de son groupe : il porte l'état de sa partie dans ses propres scores et ses
joueurs sont ceux qui le chevauchent, donc plusieurs groupes peuvent faire le parcours en même temps sans se voir.

# Le parcours, en command blocks
Tout se repère par rapport au point d'exécution, donc depuis un command block c'est le bloc lui même qui
sert de repère. Chaque fonction ne touche que les gens à moins de TRIGGER_RADIUS (3) blocs, et toutes sont
faites pour être posées dans un command block répétitif : elles ne font rien quand il n'y a personne à prendre.

	/function survisland:modes/all_together/start                    départ, groupe les joueurs libres qui passent ici
	/function survisland:modes/all_together/here/set_phase/riviere   début d'une partie, ne fait rien si le groupe y est déjà
	/function survisland:modes/all_together/here/stop                fin du parcours, rend son corps au groupe qui passe ici

Le start ne démarre que s'il trouve au moins START_PLAYERS joueurs libres (ni creative, ni spectator, ni déjà
en jeu) : un groupe déjà lancé n'est jamais cassé par un autre groupe qui démarre juste à côté.
Les quatre plus proches sont pris dans l'ordre de leur distance (le plus proche devient le Joueur 1),
leur mannequin est invoqué sur ce Joueur 1 et ils sont aussitôt montés dessus.

# Les commandes d'admin
Les fonctions "here/" existent aussi sans le préfixe, pour agir sur tous les groupes d'un coup :

	/function survisland:modes/all_together/here/next_phase          passe ce groupe à la partie suivante
	/function survisland:modes/all_together/here/shuffle_slots       décalage P1->P2, P2->P3, etc
	/function survisland:modes/all_together/stop                     arrête tout, partout

# Dans le code
Tout le reste vit dans phases.py : PHASES contient le set de commandes de chaque partie
(le seul endroit à éditer pour changer qui contrôle quoi), et les constantes juste à côté tiennent les rayons,
les vitesses et la touche utilisée pour allonger le mannequin.
"""
# Imports
from stewbeet import JsonDict, Mem, Predicate, set_json_encoder, write_function

from .controls import (
	attribute_lines,
	generate_body_tick,
	generate_dispatchers,
	generate_phase_functions,
	generate_tick,
)
from .phases import (
	ACTIONS,
	BACK_SPEED,
	GROUP_RADIUS,
	GROUP_SIZE,
	INPUT_KEYS,
	MANNEQUIN_PROFILE,
	MODE,
	PHASES,
	SNEAK_SPEED,
	SPRINT_SPEED,
	START_PLAYERS,
	TRIGGER_RADIUS,
	WALK_SPEED,
)


# Functions
def state_objectives() -> list[str]:
	""" List the objectives holding the state of a group, all of them carried by its own mannequin

	Returns:
		The objective names, the first one being the player slot objective

	>>> state_objectives()[0].endswith("all_together")
	True
	"""
	ns: str = Mem.ctx.project_id
	return [f"{ns}.{MODE}"] + [f"{ns}.{MODE}.{name}" for name in ("group", "phase", "pose", "sprint", "moving")]


def generate_player_helpers() -> None:
	""" Write the per player passes shared by the start and the stop, each one running on a free @s. """
	ns: str = Mem.ctx.project_id
	tag: str = f"{ns}.{MODE}"
	clear_tags: str = "\n".join(f"tag @s remove {tag}.{action.name}" for action in ACTIONS)
	resets: dict[str, str] = dict.fromkeys(("scale", "gravity", "fall_damage_multiplier", "camera_distance", "entity_interaction_range", "block_interaction_range", "block_break_speed"), "reset")

	write_function(f"{ns}:modes/{MODE}/body/clear_player", f"""
{clear_tags}
tag @s remove {tag}
""")

	write_function(f"{ns}:modes/{MODE}/body/release_player", f"""
# Give this player its own body back
execute if predicate {ns}:riding run ride @s dismount
gamemode adventure @s
effect clear @s minecraft:invisibility
effect clear @s minecraft:resistance
{attribute_lines(resets)}

function {ns}:modes/{MODE}/body/clear_player
""")

	write_function(f"{ns}:modes/{MODE}/body/setup_player", f"""
# Turn this player into an invisible sensor (scale is clamped to 0.0625 by vanilla, 0 is impossible)
gamemode adventure @s
effect give @s minecraft:invisibility infinite 255 true
effect give @s minecraft:resistance infinite 255 true
attribute @s minecraft:scale base set 0.0625
attribute @s minecraft:gravity base set 0
attribute @s minecraft:fall_damage_multiplier base set 0
attribute @s minecraft:camera_distance base set 24

tellraw @s ["\\n",{{"nbt":"Survisland","storage":"{ns}:main","interpret":true}},{{"text":" Vous ne faites plus qu'un ! Chacun n'a qu'une partie des commandes."}}]
""")


def generate_predicates() -> None:
	""" Write the predicates read every tick: one per readable key, plus the two entity states the tick needs. """
	ns: str = Mem.ctx.project_id
	predicates: dict[str, JsonDict] = {f"input/{key}": {"minecraft:type_specific/player": {"input": {key: True}}} for key in INPUT_KEYS}
	predicates["on_ground"] = {"minecraft:flags": {"is_on_ground": True}}
	predicates["riding"] = {"minecraft:vehicle": {}}

	for path, entity_predicate in predicates.items():
		json_content: JsonDict = {"condition": "minecraft:entity_properties", "entity": "this", "predicate": entity_predicate}
		Mem.ctx.data[ns].predicates[path] = set_json_encoder(Predicate(json_content), max_level=-1)


def generate_start() -> None:
	""" Write the function starting one group, safe to run every tick from a command block. """
	ns: str = Mem.ctx.project_id
	tag: str = f"{ns}.{MODE}"
	free_player: str = f"tag=!{tag},distance=..{TRIGGER_RADIUS},gamemode=!creative,gamemode=!spectator"
	objectives: str = "\n".join(f"scoreboard objectives add {name} dummy" for name in state_objectives())
	profile: str = f',profile:"{MANNEQUIN_PROFILE}"' if MANNEQUIN_PROFILE else ""

	write_function(f"{ns}:modes/{MODE}/start", f"""
# Objectives of the mode, all but the first one are carried by the mannequins themselves
{objectives}

# Speeds shared by every group, in thousandths of a block per tick
scoreboard players set #{MODE}_speed_walk {ns}.data {WALK_SPEED}
scoreboard players set #{MODE}_speed_sprint {ns}.data {SPRINT_SPEED}
scoreboard players set #{MODE}_speed_back {ns}.data {BACK_SPEED}
scoreboard players set #{MODE}_speed_sneak {ns}.data {SNEAK_SPEED}

# Nothing happens until enough free players stand here, so a group already playing is never disturbed
execute store result score #{MODE}_free {ns}.data if entity @a[{free_player}]
execute if score #{MODE}_free {ns}.data matches ..{START_PLAYERS - 1} run return 0

# The nearest free players become the controllers of this new group, the closest one being the Joueur 1
scoreboard players add #{MODE}_group_counter {ns}.data 1
scoreboard players set #{MODE}_slot {ns}.data 0
execute as @a[{free_player},limit={GROUP_SIZE},sort=nearest] run function {ns}:modes/{MODE}/body/enroll_player

# Their body is summoned on the Joueur 1, never on the caller which may be a command block inside a wall
execute at @a[tag={tag}.new,scores={{{tag}=1}},limit=1] summon minecraft:mannequin run function {ns}:modes/{MODE}/body/new
tag @a[tag={tag}.new] remove {tag}.new

schedule function {ns}:modes/{MODE}/tick 1t replace
""")

	write_function(f"{ns}:modes/{MODE}/body/new", f"""
# Identity and state of this body
tag @s add {tag}.body
data merge entity @s {{immovable:0b,hide_description:1b,Invulnerable:1b{profile}}}
scoreboard players operation @s {tag}.group = #{MODE}_group_counter {ns}.data
scoreboard players set @s {tag}.phase 0
scoreboard players set @s {tag}.pose 0
scoreboard players set @s {tag}.sprint 0
scoreboard players set @s {tag}.moving 0

# The seat carrying the click holder in front of the face, since the head is already taken by the others
execute at @s summon minecraft:item_display run function {ns}:modes/{MODE}/body/new_seat

execute at @s run function {ns}:modes/{MODE}/body/setup_sensors
""")

	write_function(f"{ns}:modes/{MODE}/body/new_seat", f"""
tag @s add {tag}.seat
scoreboard players operation @s {tag}.group = #{MODE}_group_counter {ns}.data
""")

	write_function(f"{ns}:modes/{MODE}/body/setup_sensors", f"""
# The freshly enrolled players are still scattered around the start block, so they are taken by tag
scoreboard players operation @a[tag={tag}.new] {tag}.group = @s {tag}.group
execute as @a[tag={tag}.new] run function {ns}:modes/{MODE}/body/setup_player

# Deals the first command set, then puts everyone on its vehicle
function {ns}:modes/{MODE}/body/enter_phase/{PHASES[0].id}
""")

	write_function(f"{ns}:modes/{MODE}/body/enroll_player", f"""
scoreboard players add #{MODE}_slot {ns}.data 1
scoreboard players operation @s {tag} = #{MODE}_slot {ns}.data
tag @s add {tag}
tag @s add {tag}.new
""")


def generate_stop() -> None:
	""" Write the function stopping every group, and the one stopping a single body. """
	ns: str = Mem.ctx.project_id
	tag: str = f"{ns}.{MODE}"
	removals: str = "\n".join(f"scoreboard objectives remove {name}" for name in state_objectives())

	write_function(f"{ns}:modes/{MODE}/body/stop", f"""
# Single scan of the group: every player is released, tags included
scoreboard players operation #{MODE}_group {ns}.data = @s {tag}.group
execute as @a[tag={tag},distance=..{GROUP_RADIUS}] if score @s {tag}.group = #{MODE}_group {ns}.data run function {ns}:modes/{MODE}/body/release_player
execute as @e[type=item_display,tag={tag}.seat,distance=..{GROUP_RADIUS}] if score @s {tag}.group = #{MODE}_group {ns}.data run kill @s
kill @s
""")

	write_function(f"{ns}:modes/{MODE}/here/stop", f"""
# Only the group whose mannequin is the nearest one
execute as @n[type=mannequin,tag={tag}.body,distance=..{TRIGGER_RADIUS}] at @s run function {ns}:modes/{MODE}/body/stop
""")

	write_function(f"{ns}:modes/{MODE}/stop", f"""
# Stop every group still running
execute as @e[type=mannequin,tag={tag}.body] at @s run function {ns}:modes/{MODE}/body/stop
kill @e[type=mannequin,tag={tag}.body]
kill @e[type=item_display,tag={tag}.seat]

# Catch anyone who ended up out of range of their body
execute as @a[tag={tag}] run function {ns}:modes/{MODE}/body/release_player

{removals}
schedule clear {ns}:modes/{MODE}/tick
""")


def main() -> None:
	""" Generate every file of the "All Together" mode. """
	generate_predicates()
	generate_player_helpers()
	generate_start()
	generate_tick()
	generate_body_tick()
	generate_phase_functions()
	generate_dispatchers()
	generate_stop()

