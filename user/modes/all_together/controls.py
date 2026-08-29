
""" Generation of the per tick control loop and of the phase switching functions.

Every function under body/ runs as and at one mannequin: it is the anchor of its group, it carries the
state of its part in its own scores, and its players are the ones glued to it within GROUP_RADIUS blocks.
Any number of groups can therefore run at the same time without knowing anything about each other.
The tick itself is generic: it only knows action tags, so changing part only redistributes those tags.

Selector discipline: a @a[...] selector is a full scan of the player list, so a group is scanned once
per function and every per player command then runs on a free @s inside a dispatched subfunction.
"""
# ruff: noqa: E501
# Imports
import json

from stewbeet import Mem, write_function

from .phases import ACTIONS, CRAWL_KEY, EYE_OFFSET, GROUP_RADIUS, GROUP_SIZE, JUMP_VELOCITY, MODE, PHASES, TRIGGER_RADIUS, Phase, actions_of_slot

# Constants
INPUTS: tuple[str, ...] = ("forward", "backward", "left", "right", "jump", "sneak", "sprint", "crawl")
""" Actions read from the players every tick, counted in #<mode>_in_<action> fake players. """


# Functions
def attribute_lines(values: dict[str, str]) -> str:
	""" Build the attribute commands of the executing entity

	Args:
		values (dict[str, str]): Attribute name -> value to set, or "reset" to give the vanilla value back
	Returns:
		str: One command per line

	Examples:
		>>> attribute_lines({"scale": "0.5"})
		'attribute @s minecraft:scale base set 0.5'
		>>> attribute_lines({"scale": "reset"})
		'attribute @s minecraft:scale base reset'
	"""
	return "\n".join(
		f"attribute @s minecraft:{name} base " + ("reset" if value == "reset" else f"set {value}")
		for name, value in values.items()
	)


def generate_tick() -> None:
	""" Write the tick of the mode, running the loop on every mannequin of the world. """
	ns: str = Mem.ctx.project_id

	write_function(f"{ns}:modes/{MODE}/tick", f"""
# The loop dies with the last group, and any start brings it back
execute unless entity @e[type=mannequin,tag={ns}.{MODE}.body,limit=1] run return 0
schedule function {ns}:modes/{MODE}/tick 1t replace

# Every group is driven from the point of view of its own mannequin (position and rotation)
execute as @e[type=mannequin,tag={ns}.{MODE}.body] at @s run function {ns}:modes/{MODE}/body/tick
""")


def generate_body_tick() -> None:
	""" Write the loop applied on one mannequin, its player pass, and the pose update it calls when needed. """
	ns: str = Mem.ctx.project_id
	tag: str = f"{ns}.{MODE}"
	reset_inputs: str = "\n".join(f"scoreboard players set #{MODE}_in_{name} {ns}.data 0" for name in INPUTS)

	write_function(f"{ns}:modes/{MODE}/body/tick", f"""
# Copy the rotation of the head holder, before the player pass forces it back on everyone
execute rotated as @a[tag={tag}.look,distance=..{GROUP_RADIUS},sort=nearest,limit=1] run rotate @s ~ ~

# Forget the inputs of the previous tick
{reset_inputs}
scoreboard players set #{MODE}_in_holders {ns}.data 0

# Single scan of the group: every sensor reports its inputs and gets stuck on the mannequin eyes
execute at @s as @a[tag={tag},distance=..{GROUP_RADIUS}] run function {ns}:modes/{MODE}/body/read_player

# Pose: 0 standing, 1 crouching, 2 lying down
scoreboard players set #{MODE}_pose {ns}.data 0
execute if score #{MODE}_in_sneak {ns}.data matches 1.. run scoreboard players set #{MODE}_pose {ns}.data 1
execute if score #{MODE}_in_crawl {ns}.data matches 1.. run scoreboard players set #{MODE}_pose {ns}.data 2
execute unless score #{MODE}_pose {ns}.data = @s {tag}.pose run function {ns}:modes/{MODE}/body/update_pose

# Speed of this tick, depending on the pose and on how the part triggers sprinting
scoreboard players operation #{MODE}_speed {ns}.data = #{MODE}_speed_walk {ns}.data
execute if score #{MODE}_pose {ns}.data matches 1.. run scoreboard players operation #{MODE}_speed {ns}.data = #{MODE}_speed_sneak {ns}.data
execute if score #{MODE}_pose {ns}.data matches 0 if score @s {tag}.sprint matches 0 if score #{MODE}_in_sprint {ns}.data matches 1.. run scoreboard players operation #{MODE}_speed {ns}.data = #{MODE}_speed_sprint {ns}.data
execute if score #{MODE}_pose {ns}.data matches 0 if score @s {tag}.sprint matches 1 if score #{MODE}_in_holders {ns}.data matches 1.. if score #{MODE}_in_forward {ns}.data = #{MODE}_in_holders {ns}.data run scoreboard players operation #{MODE}_speed {ns}.data = #{MODE}_speed_sprint {ns}.data

# Local velocity, in thousandths of a block per tick (+x is left, +z is forward)
scoreboard players set @s bs.vel.x 0
scoreboard players set @s bs.vel.z 0
execute store result score @s bs.vel.y run data get entity @s Motion[1] 1000
execute if score #{MODE}_in_forward {ns}.data matches 1.. if score #{MODE}_in_backward {ns}.data matches 0 run scoreboard players operation @s bs.vel.z = #{MODE}_speed {ns}.data
execute if score #{MODE}_in_backward {ns}.data matches 1.. if score #{MODE}_in_forward {ns}.data matches 0 run scoreboard players operation @s bs.vel.z -= #{MODE}_speed_back {ns}.data
execute if score #{MODE}_in_left {ns}.data matches 1.. if score #{MODE}_in_right {ns}.data matches 0 run scoreboard players operation @s bs.vel.x = #{MODE}_speed {ns}.data
execute if score #{MODE}_in_right {ns}.data matches 1.. if score #{MODE}_in_left {ns}.data matches 0 run scoreboard players operation @s bs.vel.x -= #{MODE}_speed {ns}.data
execute if score #{MODE}_in_jump {ns}.data matches 1.. if entity @s[nbt={{OnGround:1b}}] run scoreboard players set @s bs.vel.y {JUMP_VELOCITY}

# Hand the velocity over to the vanilla physics (collisions, step up, gravity and fall are free)
execute rotated ~ 0 run function #bs.move:local_to_canonical
function #bs.move:set_motion {{scale:0.001}}
""")

	read_inputs: str = "\n".join(
		f"execute if entity @s[tag={tag}.{name},predicate={ns}:input/{CRAWL_KEY if name == 'crawl' else name}] run scoreboard players add #{MODE}_in_{name} {ns}.data 1"
		for name in INPUTS
	)
	write_function(f"{ns}:modes/{MODE}/body/read_player", f"""
# Stick this sensor on the mannequin eyes, and lock its view on the mannequin aim
tp @s ~ ~{EYE_OFFSET} ~ ~ ~

# Report the keys it is holding down (crawl has no vanilla key, it is read on CRAWL_KEY)
{read_inputs}
execute if entity @s[tag={tag}.forward] run scoreboard players add #{MODE}_in_holders {ns}.data 1
""")

	write_function(f"{ns}:modes/{MODE}/body/update_pose", f"""
scoreboard players operation @s {tag}.pose = #{MODE}_pose {ns}.data
execute if score #{MODE}_pose {ns}.data matches 0 run data modify entity @s pose set value "standing"
execute if score #{MODE}_pose {ns}.data matches 1 run data modify entity @s pose set value "crouching"
execute if score #{MODE}_pose {ns}.data matches 2 run data modify entity @s pose set value "swimming"
""")


def phase_help_message(phase: Phase) -> str:
	""" Build the tellraw listing the command set of every slot for a phase

	Args:
		phase (Phase): The phase to describe
	Returns:
		str: The JSON text component, ready to be pasted in a tellraw

	Examples:
		>>> '"Joueur 1 : "' in phase_help_message(PHASES[1])
		True
	"""
	components: list[dict[str, str]] = [{"text": "\n"}]
	for slot in range(1, GROUP_SIZE + 1):
		actions: str = " / ".join(action.display for action in actions_of_slot(phase, slot)) or "Rien du tout"
		components.append({"text": f"Joueur {slot} : ", "color": "yellow"})
		components.append({"text": f"{actions}\n", "color": "white"})
	return json.dumps(components, ensure_ascii=False)


def generate_phase_functions() -> None:
	""" Write the phase functions applied on one mannequin, and their player pass. """
	ns: str = Mem.ctx.project_id
	tag: str = f"{ns}.{MODE}"

	for index, phase in enumerate(PHASES):
		write_function(f"{ns}:modes/{MODE}/body/set_phase/{phase.id}", f"""
# Idempotent, so the command block of the part can keep firing on the group standing on it
execute if score @s {tag}.phase matches {index} run return 0
function {ns}:modes/{MODE}/body/enter_phase/{phase.id}
""")

		write_function(f"{ns}:modes/{MODE}/body/enter_phase/{phase.id}", f"""
# Remember which part this group is running and how sprinting is triggered
scoreboard players set @s {tag}.phase {index}
scoreboard players set @s {tag}.sprint {int(phase.sprint_when_all_forward)}

# Single scan of the group: every player is dealt its own command set
execute as @a[tag={tag},distance=..{GROUP_RADIUS}] run function {ns}:modes/{MODE}/body/deal/{phase.id}
""")

		clear_tags: str = "\n".join(f"tag @s remove {tag}.{action.name}" for action in ACTIONS)
		give_tags: str = "\n".join(
			f"execute if score @s {tag} matches {slot} run tag @s add {tag}.{action.name}"
			for action in ACTIONS
			for slot in phase.bindings.get(action.name, ())
		)
		write_function(f"{ns}:modes/{MODE}/body/deal/{phase.id}", f"""
# Clear the previous command set
{clear_tags}

# Give the command set of this part
{give_tags}

# Only the click holders keep a usable interaction range
attribute @s minecraft:entity_interaction_range base set 0
attribute @s minecraft:block_interaction_range base set 0
execute if entity @s[tag={tag}.click] run attribute @s minecraft:entity_interaction_range base reset
execute if entity @s[tag={tag}.click] run attribute @s minecraft:block_interaction_range base reset

# Announce the new command set
title @s title {json.dumps({"text": phase.display, "color": "gold"}, ensure_ascii=False)}
title @s subtitle {json.dumps({"text": "Nouveau set de commandes", "color": "gray"}, ensure_ascii=False)}
tellraw @s {phase_help_message(phase)}
playsound block.note_block.pling master @s
""")

	apply_phase: str = "\n".join(
		f"execute if score @s {tag}.phase matches {index} run return run function {ns}:modes/{MODE}/body/enter_phase/{phase.id}"
		for index, phase in enumerate(PHASES)
	)
	write_function(f"{ns}:modes/{MODE}/body/apply_phase", f"""
# Deal the current command set again, even when the group is already in that part
{apply_phase}
""")

	write_function(f"{ns}:modes/{MODE}/body/next_phase", f"""
scoreboard players add @s {tag}.phase 1
execute if score @s {tag}.phase matches {len(PHASES)}.. run scoreboard players set @s {tag}.phase 0
function {ns}:modes/{MODE}/body/apply_phase
""")

	write_function(f"{ns}:modes/{MODE}/body/shuffle_slots", f"""
# Everyone of this group moves to the next slot, then the current command set is dealt again
scoreboard players add @a[tag={tag},distance=..{GROUP_RADIUS}] {tag} 1
scoreboard players set @a[tag={tag},distance=..{GROUP_RADIUS},scores={{{tag}={GROUP_SIZE + 1}..}}] {tag} 1
function {ns}:modes/{MODE}/body/apply_phase
""")


def generate_dispatchers() -> None:
	""" Write the admin commands, in two flavours: every group at once, or only the group standing here. """
	ns: str = Mem.ctx.project_id
	targets: list[tuple[str, str]] = [("next_phase", "body/next_phase"), ("shuffle_slots", "body/shuffle_slots")]
	targets += [(f"set_phase/{phase.id}", f"body/set_phase/{phase.id}") for phase in PHASES]

	for name, called in targets:
		write_function(f"{ns}:modes/{MODE}/{name}", f"""
# Every group at once, use the here/ version to handle a single one
execute as @e[type=mannequin,tag={ns}.{MODE}.body] at @s run function {ns}:modes/{MODE}/{called}
""")
		write_function(f"{ns}:modes/{MODE}/here/{name}", f"""
# Only the group whose mannequin is the nearest one
execute as @n[type=mannequin,tag={ns}.{MODE}.body,distance=..{TRIGGER_RADIUS}] at @s run function {ns}:modes/{MODE}/{called}
""")

