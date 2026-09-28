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

Le start ne démarre que s'il trouve assez de joueurs libres (ni creative, ni spectator, ni déjà en jeu) :
un groupe déjà lancé n'est jamais cassé par un autre groupe qui démarre juste à côté.
Les joueurs sont pris dans l'ordre de leur distance et répartis en groupes (le plus proche de chaque groupe
devient son Joueur 1), leur mannequin est invoqué sur ce Joueur 1 et ils sont aussitôt montés dessus.

# Les commandes d'admin
Les fonctions "here/" existent aussi sans le préfixe, pour agir sur tous les groupes d'un coup :

	/function survisland:modes/all_together/here/next_phase          passe ce groupe à la partie suivante
	/function survisland:modes/all_together/here/shuffle_slots       décalage P1->P2, P2->P3, etc
	/function survisland:modes/all_together/stop                     arrête tout, partout

# Dans le code
Tout le reste vit dans phases.py : un CrewMode décrit un mode (dossier, taille des groupes, sets de commandes),
et les constantes juste à côté tiennent les rayons, les vitesses et la touche utilisée pour allonger le mannequin.
Le même générateur sert au duo du laboratoire du professeur Stoupy, avec son propre CrewMode.
"""
# ruff: noqa: E501
# Imports
from stewbeet import JsonDict, Mem, Predicate, set_json_encoder, write_function

from user.utils.player_head import PLAYER_HEAD_LOOT_TABLE

from .controls import (
	attribute_lines,
	generate_body_tick,
	generate_dispatchers,
	generate_phase_functions,
	generate_tick,
)
from .phases import (
	ACTIONS,
	ALL_TOGETHER,
	BACK_SPEED,
	INPUT_KEYS,
	RADIUS,
	SNEAK_SPEED,
	SPRINT_SPEED,
	TRIGGER_RADIUS,
	WALK_SPEED,
	CrewMode,
)


# Functions
def state_objectives(mode: CrewMode) -> list[str]:
	""" List the objectives holding the state of a group, all of them carried by its own mannequin

	Returns:
		The objective names, the first one being the player slot objective

	>>> state_objectives(ALL_TOGETHER)[0].endswith("all_together")
	True
	"""
	tag: str = f"{Mem.ctx.project_id}.{mode.id}"
	return [tag] + [f"{tag}.{name}" for name in ("group", "phase", "pose", "sprint", "moving")]


def generate_player_helpers(mode: CrewMode) -> None:
	""" Write the per player passes shared by the start and the stop, each one running on a free @s. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{mode.path}"
	tag: str = f"{ns}.{mode.id}"
	clear_tags: str = "\n".join(f"tag @s remove {tag}.{action.name}" for action in ACTIONS)
	resets: dict[str, str] = dict.fromkeys(("scale", "gravity", "fall_damage_multiplier", "camera_distance", "entity_interaction_range", "block_interaction_range", "block_break_speed"), "reset")

	write_function(f"{root}/body/clear_player", f"""
{clear_tags}
tag @s remove {tag}
""")

	write_function(f"{root}/body/release_player", f"""
# Give this player its own body back
execute if predicate {ns}:riding run ride @s dismount
effect clear @s minecraft:invisibility
effect clear @s minecraft:resistance
{attribute_lines(resets)}

function {root}/body/clear_player
""")

	write_function(f"{root}/body/setup_player", f"""
# Turn this player into an invisible sensor (scale is clamped to 0.0625 by vanilla, 0 is impossible)
effect give @s minecraft:invisibility infinite 255 true
effect give @s minecraft:resistance infinite 255 true
attribute @s minecraft:scale base set 0.0625
attribute @s minecraft:gravity base set 0
attribute @s minecraft:fall_damage_multiplier base set 0
attribute @s minecraft:camera_distance base set 32

tellraw @s ["\\n",{{"nbt":"Survisland","storage":"{ns}:main","interpret":true}},{{"text":" Vous ne faites plus qu'un ! Chacun n'a qu'une partie des commandes."}}]
""")


def generate_predicates(mode: CrewMode) -> None:
	""" Write the predicates read every tick: one per readable key, the two entity states the tick needs, and the group filter of the mode. """
	ns: str = Mem.ctx.project_id
	predicates: dict[str, JsonDict] = {f"input/{key}": {"minecraft:type_specific/player": {"input": {key: True}}} for key in INPUT_KEYS}
	predicates["on_ground"] = {"minecraft:flags": {"is_on_ground": True}}
	predicates["riding"] = {"minecraft:vehicle": {}}

	for path, entity_predicate in predicates.items():
		json_content: JsonDict = {"condition": "minecraft:entity_properties", "entity": "this", "predicate": entity_predicate}
		Mem.ctx.data[ns].predicates[path] = set_json_encoder(Predicate(json_content), max_level=-1)

	# Inside a selector it filters before limit and sort, where an "if score" after the selector would come too late
	group: JsonDict = {"type": "minecraft:score", "target": {"type": "minecraft:fixed", "name": f"#{mode.id}_group"}, "score": f"{ns}.data"}
	same_group: JsonDict = {"condition": "minecraft:entity_scores", "entity": "this", "scores": {f"{ns}.{mode.id}.group": {"min": group, "max": group}}}
	Mem.ctx.data[ns].predicates[f"{mode.path}/same_group"] = set_json_encoder(Predicate(same_group), max_level=-1)


def generate_start(mode: CrewMode) -> None:
	""" Write the function starting the groups, safe to run every tick from a command block. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{mode.path}"
	tag: str = f"{ns}.{mode.id}"
	free_player: str = f"tag=!{tag},{mode.start_filter},gamemode=!creative,gamemode=!spectator"
	solo_guard: str = f"unless score {mode.solo_flag} matches 1 " if mode.solo_flag else ""
	objectives: str = "\n".join(f"scoreboard objectives add {name} dummy" for name in state_objectives(mode))
	form_groups: str = "\n".join(f"function {root}/body/form_group" for _ in range(mode.start_players // mode.group_size))
	skin: str = (
		f'data modify entity @s profile set value "{mode.profile}"' if mode.profile
		else f"execute as @a[tag={tag}.new,scores={{{tag}=1}},limit=1] run loot replace entity @n[type=mannequin,tag={tag}.body,distance=..1] weapon.mainhand loot {PLAYER_HEAD_LOOT_TABLE}\n"
		+ 'data modify entity @s profile set from entity @s equipment.mainhand.components."minecraft:profile"\n'
		+ "item replace entity @s weapon.mainhand with minecraft:air"
	)

	write_function(f"{root}/start", f"""
# Objectives of the mode, all but the first one are carried by the mannequins themselves
{objectives}

# Speeds shared by every group, in thousandths of a block per tick
scoreboard players set #{mode.id}_speed_walk {ns}.data {WALK_SPEED}
scoreboard players set #{mode.id}_speed_sprint {ns}.data {SPRINT_SPEED}
scoreboard players set #{mode.id}_speed_back {ns}.data {BACK_SPEED}
scoreboard players set #{mode.id}_speed_sneak {ns}.data {SNEAK_SPEED}

# Nothing happens until enough free players stand here, so a group already playing is never disturbed
execute store result score #{mode.id}_free {ns}.data if entity @a[{free_player}]
execute if score #{mode.id}_free {ns}.data matches 0 run return 0
execute {solo_guard}if score #{mode.id}_free {ns}.data matches ..{mode.start_players - 1} run return 0

# The nearest free players are split into groups, each one taking the closest players still free
{form_groups}

schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/body/form_group", f"""
# The closest one becomes the Joueur 1 of this new group
scoreboard players add #{mode.id}_group_counter {ns}.data 1
scoreboard players set #{mode.id}_slot {ns}.data 0
execute as @a[{free_player},limit={mode.group_size},sort=nearest] run function {root}/body/enroll_player

# Their body is summoned on the Joueur 1, never on the caller which may be a command block inside a wall
execute at @a[tag={tag}.new,scores={{{tag}=1}},limit=1] summon minecraft:mannequin run function {root}/body/new
tag @a[tag={tag}.new] remove {tag}.new
""")

	write_function(f"{root}/body/new", f"""
# Identity and state of this body
tag @s add {tag}.body
data merge entity @s {{immovable:0b,hide_description:1b,Invulnerable:1b}}
attribute @s minecraft:camera_distance base set {mode.camera_distance}
{skin}
scoreboard players operation @s {tag}.group = #{mode.id}_group_counter {ns}.data
scoreboard players operation #{mode.id}_group {ns}.data = @s {tag}.group
scoreboard players set @s {tag}.phase 0
scoreboard players set @s {tag}.pose 0
scoreboard players set @s {tag}.sprint 0
scoreboard players set @s {tag}.moving 0

# The seat carrying the click holder in front of the face, since the head is already taken by the others
execute at @s summon minecraft:item_display run function {root}/body/new_seat

execute at @s run function {root}/body/setup_sensors
""")

	write_function(f"{root}/body/new_seat", f"""
tag @s add {tag}.seat
scoreboard players operation @s {tag}.group = #{mode.id}_group {ns}.data
data merge entity @s {{teleport_duration:1}}
""")

	write_function(f"{root}/body/setup_sensors", f"""
# The freshly enrolled players are still scattered around the start block, so they are taken by tag
scoreboard players operation @a[tag={tag}.new] {tag}.group = @s {tag}.group
execute as @a[tag={tag}.new] run function {root}/body/setup_player

# Deals the first command set, then puts everyone on its vehicle
function {root}/body/enter_phase/{mode.phases[0].id}
""")

	write_function(f"{root}/body/enroll_player", f"""
scoreboard players add #{mode.id}_slot {ns}.data 1
scoreboard players operation @s {tag} = #{mode.id}_slot {ns}.data
tag @s add {tag}
tag @s add {tag}.new
""")


def generate_stop(mode: CrewMode) -> None:
	""" Write the function stopping every group, and the one stopping a single body. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{mode.path}"
	tag: str = f"{ns}.{mode.id}"
	same_group: str = f"predicate={ns}:{mode.path}/same_group"
	removals: str = "\n".join(f"scoreboard objectives remove {name}" for name in state_objectives(mode))

	write_function(f"{root}/body/stop", f"""
# Single scan of the group: every player is released, tags included
scoreboard players operation #{mode.id}_group {ns}.data = @s {tag}.group
execute as @a[tag={tag},{same_group},distance=..{RADIUS}] run function {root}/body/release_player
kill @e[type=item_display,tag={tag}.seat,{same_group},distance=..{RADIUS}]
kill @s
""")

	write_function(f"{root}/here/stop", f"""
# Only the group whose mannequin is the nearest one
execute as @n[type=mannequin,tag={tag}.body,distance=..{TRIGGER_RADIUS}] at @s run function {root}/body/stop
""")

	write_function(f"{root}/stop", f"""
# Stop every group still running
execute as @e[type=mannequin,tag={tag}.body] at @s run function {root}/body/stop
kill @e[type=mannequin,tag={tag}.body]
kill @e[type=item_display,tag={tag}.seat]

# Catch anyone who ended up out of range of their body
execute as @a[tag={tag}] run function {root}/body/release_player

{removals}
schedule clear {root}/tick
""")


def generate_crew_mode(mode: CrewMode) -> None:
	""" Generate every file of a mode built on the shared mannequin. """
	generate_predicates(mode)
	generate_player_helpers(mode)
	generate_start(mode)
	generate_tick(mode)
	generate_body_tick(mode)
	generate_phase_functions(mode)
	generate_dispatchers(mode)
	generate_stop(mode)


def main() -> None:
	""" Generate every file of the "All Together" mode. """
	generate_crew_mode(ALL_TOGETHER)

