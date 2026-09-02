
""" Generation of the per tick control loop and of the phase switching functions.

Every function under body/ runs as and at one mannequin: it is the anchor of its group, it carries the
state of its part in its own scores, and its players are the ones riding it.
Any number of groups can therefore run at the same time without knowing anything about each other.
The tick itself is generic: it only knows action tags, so changing part only redistributes those tags.

Selector discipline: the group is reached with "execute on passengers", which walks the passenger list of the
mannequin and of its click seat instead of scanning the world. Vanilla reads a shift press as a dismount,
so the crew is counted while it is read and a bounded @a scan puts back whoever fell off, only on those ticks.
"""
# ruff: noqa: E501
# Imports
import json

from stewbeet import Mem, write_function

from .phases import (
	ACTIONS,
	CLICK_OFFSET,
	CRAWL_KEY,
	GROUP_RADIUS,
	GROUP_SIZE,
	JUMP_VELOCITY,
	MODE,
	PHASES,
	SEAT_RADIUS,
	SPRINT_HOLD,
	TRIGGER_RADIUS,
	Phase,
	actions_of_slot,
)

# Constants
INPUTS: tuple[str, ...] = ("forward", "backward", "left", "right", "jump", "sneak", "sprint", "crawl")
""" Actions read from the players every tick, counted in #<mode>_in_<action> fake players. """


# Functions
def attribute_lines(values: dict[str, str]) -> str:
	""" Build the attribute commands of the executing entity

	Args:
		values: Attribute name -> value to set, or "reset" to give the vanilla value back
	Returns:
		One command per line

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
# One scan of the world per tick, and the loop dies with the last group since any start brings it back
scoreboard players set #{MODE}_alive {ns}.data 0
execute as @e[type=mannequin,tag={ns}.{MODE}.body] at @s run function {ns}:modes/{MODE}/body/tick
execute if score #{MODE}_alive {ns}.data matches 1.. run schedule function {ns}:modes/{MODE}/tick 1t replace
""")


def generate_body_tick() -> None:
	""" Write the loop applied on one mannequin, the passes reading and seating its group, and the pose update. """
	ns: str = Mem.ctx.project_id
	tag: str = f"{ns}.{MODE}"
	reset_inputs: str = "\n".join(f"scoreboard players set #{MODE}_in_{name} {ns}.data 0" for name in INPUTS)

	write_function(f"{ns}:modes/{MODE}/body/tick", f"""
scoreboard players add #{MODE}_alive {ns}.data 1
scoreboard players operation #{MODE}_group {ns}.data = @s {tag}.group

# The mouse holder aims the mannequin, and the mannequin aims everyone else
execute on passengers if entity @s[tag={tag}.look] rotated as @s on vehicle run function {ns}:modes/{MODE}/body/aim

# Forget the inputs of the previous tick, then let every rider report the keys it holds down
{reset_inputs}
scoreboard players set #{MODE}_crew {ns}.data 0
execute on passengers run function {ns}:modes/{MODE}/body/read_player
execute rotated as @s anchored eyes positioned ^ ^ ^{CLICK_OFFSET} as @e[type=item_display,tag={tag}.seat,distance=..{SEAT_RADIUS}] if score @s {tag}.group = #{MODE}_group {ns}.data run function {ns}:modes/{MODE}/body/seat_tick

# Vanilla reads shift as a dismount, so whoever fell off is put back on and read right away
execute unless score #{MODE}_crew {ns}.data matches {GROUP_SIZE} run function {ns}:modes/{MODE}/body/remount

# Only the mouse holder keeps its own aim, the others look through the same eyes
execute rotated as @s on passengers unless entity @s[tag={tag}.look] run function {ns}:modes/{MODE}/body/aim

# Pose: 0 standing, 1 crouching, 2 lying down
scoreboard players set #{MODE}_pose {ns}.data 0
execute if score #{MODE}_in_sneak {ns}.data matches 1.. run scoreboard players set #{MODE}_pose {ns}.data 1
execute if score #{MODE}_in_crawl {ns}.data matches 1.. run scoreboard players set #{MODE}_pose {ns}.data 2
execute unless score #{MODE}_pose {ns}.data = @s {tag}.pose run function {ns}:modes/{MODE}/body/update_pose

# Speed of this tick, walking unless the group crouches or sprints
scoreboard players operation #{MODE}_speed {ns}.data = #{MODE}_speed_walk {ns}.data
execute if score #{MODE}_pose {ns}.data matches 1.. run scoreboard players operation #{MODE}_speed {ns}.data = #{MODE}_speed_sneak {ns}.data

# A held sprint key flips on every keyboard repeat with Toggle Sprint on, so the press is latched for SPRINT_HOLD ticks
execute if score @s {tag}.sprint matches 1.. run scoreboard players remove @s {tag}.sprint 1
execute if score #{MODE}_in_sprint {ns}.data matches 1.. run scoreboard players set @s {tag}.sprint {SPRINT_HOLD}
execute if score #{MODE}_pose {ns}.data matches 0 if score @s {tag}.sprint matches 1.. run scoreboard players operation #{MODE}_speed {ns}.data = #{MODE}_speed_sprint {ns}.data

# Local velocity, in thousandths of a block per tick (+x is left, +z is forward)
scoreboard players set @s bs.vel.x 0
scoreboard players set @s bs.vel.y 0
scoreboard players set @s bs.vel.z 0
execute if score #{MODE}_in_forward {ns}.data matches 1.. if score #{MODE}_in_backward {ns}.data matches 0 run scoreboard players operation @s bs.vel.z = #{MODE}_speed {ns}.data
execute if score #{MODE}_in_backward {ns}.data matches 1.. if score #{MODE}_in_forward {ns}.data matches 0 run scoreboard players operation @s bs.vel.z -= #{MODE}_speed_back {ns}.data
execute if score #{MODE}_in_left {ns}.data matches 1.. if score #{MODE}_in_right {ns}.data matches 0 run scoreboard players operation @s bs.vel.x = #{MODE}_speed {ns}.data
execute if score #{MODE}_in_right {ns}.data matches 1.. if score #{MODE}_in_left {ns}.data matches 0 run scoreboard players operation @s bs.vel.x -= #{MODE}_speed {ns}.data
execute if score #{MODE}_in_jump {ns}.data matches 1.. if predicate {ns}:on_ground run scoreboard players set @s bs.vel.y {JUMP_VELOCITY}

# Gravity owns the vertical motion, so it is only written on the tick the group jumps
execute if score @s bs.vel.y matches 1.. store result entity @s Motion[1] double 0.001 run scoreboard players get @s bs.vel.y

# Writing Motion costs a full entity save, so a group standing still writes its stop once and then nothing
scoreboard players set #{MODE}_moving {ns}.data 0
execute unless score @s bs.vel.x matches 0 run scoreboard players set #{MODE}_moving {ns}.data 1
execute unless score @s bs.vel.z matches 0 run scoreboard players set #{MODE}_moving {ns}.data 1
execute if score #{MODE}_moving {ns}.data matches 0 if score @s {tag}.moving matches 0 run return 0
scoreboard players operation @s {tag}.moving = #{MODE}_moving {ns}.data

# Hand the velocity over to the vanilla physics (collisions, step up, gravity and fall are free)
execute if score #{MODE}_moving {ns}.data matches 1 rotated as @s rotated ~ 0 run function #bs.move:local_to_canonical
execute store result entity @s Motion[0] double 0.001 run scoreboard players get @s bs.vel.x
execute store result entity @s Motion[2] double 0.001 run scoreboard players get @s bs.vel.z
""")

	write_function(f"{ns}:modes/{MODE}/body/aim", """
# Yaw first, from the flattened aim: a point straight above the feet has no direction to read a yaw from
execute anchored feet positioned as @s rotated ~ 0 positioned ^ ^ ^8 run rotate @s facing ~ ~ ~

# Then the pitch, nudged along the yaw just set so aiming straight down keeps that yaw instead of losing it
execute anchored feet positioned as @s positioned ^ ^ ^8 rotated as @s positioned ^ ^ ^0.01 run rotate @s facing ~ ~ ~
""")

	write_function(f"{ns}:modes/{MODE}/body/seat_tick", f"""
# The seat is dropped on the point the caller computed, in front of the mannequin eyes
tp @s ~ ~ ~
execute on passengers run function {ns}:modes/{MODE}/body/read_player
execute on passengers run function {ns}:modes/{MODE}/body/aim
""")

	read_inputs: str = "\n".join(
		f"execute if entity @s[tag={tag}.{name},predicate={ns}:input/{CRAWL_KEY if name == 'crawl' else name}] run scoreboard players add #{MODE}_in_{name} {ns}.data 1"
		for name in INPUTS
	)
	write_function(f"{ns}:modes/{MODE}/body/read_player", f"""
scoreboard players add #{MODE}_crew {ns}.data 1

# Report the keys it is holding down (crawl has no vanilla key, it is read on CRAWL_KEY)
{read_inputs}
""")

	write_function(f"{ns}:modes/{MODE}/body/remount", f"""
# The only pass still scanning the players, and it only runs while someone is off its vehicle
execute as @a[tag={tag},distance=..{GROUP_RADIUS}] if score @s {tag}.group = #{MODE}_group {ns}.data run function {ns}:modes/{MODE}/body/mount_player
""")

	write_function(f"{ns}:modes/{MODE}/body/mount_player", f"""
execute on vehicle run return 0
execute if entity @s[tag={tag}.click] run return run function {ns}:modes/{MODE}/body/mount_seat
ride @s mount @e[type=mannequin,tag={tag}.body,distance=..0.5,limit=1]
function {ns}:modes/{MODE}/body/read_player
""")

	write_function(f"{ns}:modes/{MODE}/body/mount_seat", f"""
ride @s mount @e[type=item_display,tag={tag}.seat,distance=..{SEAT_RADIUS},limit=1]
function {ns}:modes/{MODE}/body/read_player
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
		phase: The phase to describe
	Returns:
		The JSON text component, ready to be pasted in a tellraw

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

	write_function(f"{ns}:modes/{MODE}/body/deal_click", """
# Adventure breaks nothing, and riding counts as being in the air which divides the mining speed by five
gamemode survival @s
attribute @s minecraft:block_break_speed base set 5
attribute @s minecraft:entity_interaction_range base reset
attribute @s minecraft:block_interaction_range base reset
""")

	for index, phase in enumerate(PHASES):
		write_function(f"{ns}:modes/{MODE}/body/set_phase/{phase.id}", f"""
# Idempotent, so the command block of the part can keep firing on the group standing on it
execute if score @s {tag}.phase matches {index} run return 0
function {ns}:modes/{MODE}/body/enter_phase/{phase.id}
""")

		write_function(f"{ns}:modes/{MODE}/body/enter_phase/{phase.id}", f"""
# Remember which part this group is running
scoreboard players set @s {tag}.phase {index}
scoreboard players operation #{MODE}_group {ns}.data = @s {tag}.group

# Single scan of the group: every player is dealt its own command set, then put back on the right vehicle
execute as @a[tag={tag},distance=..{GROUP_RADIUS}] if score @s {tag}.group = #{MODE}_group {ns}.data run function {ns}:modes/{MODE}/body/deal/{phase.id}
function {ns}:modes/{MODE}/body/remount
""")

		clear_tags: str = "\n".join(f"tag @s remove {tag}.{action.name}" for action in ACTIONS)
		give_tags: str = "\n".join(
			f"execute if score @s {tag} matches {slot} run tag @s add {tag}.{action.name}"
			for action in ACTIONS
			for slot in phase.bindings.get(action.name, ())
		)
		write_function(f"{ns}:modes/{MODE}/body/deal/{phase.id}", f"""
# The click holder rides its own seat, so a new command set can mean a new vehicle
execute if predicate {ns}:riding run ride @s dismount

# Clear the previous command set
{clear_tags}

# Give the command set of this part
{give_tags}

# Only the click holder keeps a body able to touch the world
gamemode adventure @s
attribute @s minecraft:block_break_speed base reset
attribute @s minecraft:entity_interaction_range base set 0
attribute @s minecraft:block_interaction_range base set 0
execute if entity @s[tag={tag}.click] run function {ns}:modes/{MODE}/body/deal_click

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
scoreboard players operation #{MODE}_group {ns}.data = @s {tag}.group
execute as @a[tag={tag},distance=..{GROUP_RADIUS}] if score @s {tag}.group = #{MODE}_group {ns}.data run scoreboard players add @s {tag} 1
execute as @a[tag={tag},scores={{{tag}={GROUP_SIZE + 1}..}},distance=..{GROUP_RADIUS}] if score @s {tag}.group = #{MODE}_group {ns}.data run scoreboard players set @s {tag} 1
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

