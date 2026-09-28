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
	JUMP_VELOCITY,
	RADIUS,
	SPRINT_HOLD,
	TRIGGER_RADIUS,
	CrewMode,
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


def generate_tick(mode: CrewMode) -> None:
	""" Write the tick of the mode, running the loop on every mannequin of the world. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{mode.path}"
	tag: str = f"{ns}.{mode.id}"

	write_function(f"{root}/tick", f"""
# One scan of the world per tick, and the loop dies with the last group since any start brings it back
scoreboard players set #{mode.id}_alive {ns}.data 0
execute as @e[type=mannequin,tag={tag}.body] at @s run function {root}/body/tick
execute if score #{mode.id}_alive {ns}.data matches 1.. run schedule function {root}/tick 1t replace
""")


def generate_body_tick(mode: CrewMode) -> None:
	""" Write the loop applied on one mannequin, the passes reading and seating its group, and the pose update. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{mode.path}"
	tag: str = f"{ns}.{mode.id}"
	same_group: str = f"predicate={ns}:{mode.path}/same_group"
	reset_inputs: str = "\n".join(f"scoreboard players set #{mode.id}_in_{name} {ns}.data 0" for name in INPUTS)

	write_function(f"{root}/body/tick", f"""
scoreboard players add #{mode.id}_alive {ns}.data 1
scoreboard players operation #{mode.id}_group {ns}.data = @s {tag}.group

# The mouse holder aims the mannequin, and the mannequin aims everyone else
execute on passengers if entity @s[tag={tag}.look] rotated as @s on vehicle run function {root}/body/aim

# Forget the inputs of the previous tick, then let every rider report the keys it holds down
{reset_inputs}
scoreboard players set #{mode.id}_crew {ns}.data 0
execute on passengers run function {root}/body/read_player
execute store success score #{mode.id}_seat {ns}.data rotated as @s anchored eyes positioned ^ ^ ^{CLICK_OFFSET} as @e[type=item_display,tag={tag}.seat,{same_group},distance=..{RADIUS}] run function {root}/body/seat_tick
execute if score #{mode.id}_seat {ns}.data matches 0 run function {root}/body/find_seat

# Vanilla reads shift as a dismount, so whoever fell off is put back on and read right away
execute unless score #{mode.id}_crew {ns}.data matches {mode.group_size} run function {root}/body/remount

# Only the mouse holder keeps its own aim, the others look through the same eyes
execute rotated as @s on passengers unless entity @s[tag={tag}.look] run function {root}/body/aim

# Pose: 0 standing, 1 crouching, 2 lying down
scoreboard players set #{mode.id}_pose {ns}.data 0
execute if score #{mode.id}_in_sneak {ns}.data matches 1.. run scoreboard players set #{mode.id}_pose {ns}.data 1
execute if score #{mode.id}_in_crawl {ns}.data matches 1.. run scoreboard players set #{mode.id}_pose {ns}.data 2
execute unless score #{mode.id}_pose {ns}.data = @s {tag}.pose run function {root}/body/update_pose

# Speed of this tick, walking unless the group crouches or sprints
scoreboard players operation #{mode.id}_speed {ns}.data = #{mode.id}_speed_walk {ns}.data
execute if score #{mode.id}_pose {ns}.data matches 1.. run scoreboard players operation #{mode.id}_speed {ns}.data = #{mode.id}_speed_sneak {ns}.data

# A held sprint key flips on every keyboard repeat with Toggle Sprint on, so the press is latched for SPRINT_HOLD ticks
execute if score @s {tag}.sprint matches 1.. run scoreboard players remove @s {tag}.sprint 1
execute if score #{mode.id}_in_sprint {ns}.data matches 1.. run scoreboard players set @s {tag}.sprint {SPRINT_HOLD}
execute if score #{mode.id}_pose {ns}.data matches 0 if score @s {tag}.sprint matches 1.. run scoreboard players operation #{mode.id}_speed {ns}.data = #{mode.id}_speed_sprint {ns}.data

# Local velocity, in thousandths of a block per tick (+x is left, +z is forward)
scoreboard players set @s bs.vel.x 0
scoreboard players set @s bs.vel.y 0
scoreboard players set @s bs.vel.z 0
execute if score #{mode.id}_in_forward {ns}.data matches 1.. if score #{mode.id}_in_backward {ns}.data matches 0 run scoreboard players operation @s bs.vel.z = #{mode.id}_speed {ns}.data
execute if score #{mode.id}_in_backward {ns}.data matches 1.. if score #{mode.id}_in_forward {ns}.data matches 0 run scoreboard players operation @s bs.vel.z -= #{mode.id}_speed_back {ns}.data
execute if score #{mode.id}_in_left {ns}.data matches 1.. if score #{mode.id}_in_right {ns}.data matches 0 run scoreboard players operation @s bs.vel.x = #{mode.id}_speed {ns}.data
execute if score #{mode.id}_in_right {ns}.data matches 1.. if score #{mode.id}_in_left {ns}.data matches 0 run scoreboard players operation @s bs.vel.x -= #{mode.id}_speed {ns}.data
execute if score #{mode.id}_in_jump {ns}.data matches 1.. if predicate {ns}:on_ground run scoreboard players set @s bs.vel.y {JUMP_VELOCITY}

# Gravity owns the vertical motion, so it is only written on the tick the group jumps
execute if score @s bs.vel.y matches 1.. store result entity @s Motion[1] double 0.001 run scoreboard players get @s bs.vel.y

# Writing Motion costs a full entity save, so a group standing still writes its stop once and then nothing
scoreboard players set #{mode.id}_moving {ns}.data 0
execute unless score @s bs.vel.x matches 0 run scoreboard players set #{mode.id}_moving {ns}.data 1
execute unless score @s bs.vel.z matches 0 run scoreboard players set #{mode.id}_moving {ns}.data 1
execute if score #{mode.id}_moving {ns}.data matches 0 if score @s {tag}.moving matches 0 run return 0
scoreboard players operation @s {tag}.moving = #{mode.id}_moving {ns}.data

# Hand the velocity over to the vanilla physics (collisions, step up, gravity and fall are free)
execute if score #{mode.id}_moving {ns}.data matches 1 rotated as @s rotated ~ 0 run function #bs.move:local_to_canonical
execute store result entity @s Motion[0] double 0.001 run scoreboard players get @s bs.vel.x
execute store result entity @s Motion[2] double 0.001 run scoreboard players get @s bs.vel.z
""")

	write_function(f"{root}/body/aim", """
# Yaw first, from the flattened aim: a point straight above the feet has no direction to read a yaw from
execute anchored feet positioned as @s rotated ~ 0 positioned ^ ^ ^8 run rotate @s facing ~ ~ ~

# Then the pitch, nudged along the yaw just set so aiming straight down keeps that yaw instead of losing it
execute anchored feet positioned as @s positioned ^ ^ ^8 rotated as @s positioned ^ ^ ^0.01 run rotate @s facing ~ ~ ~
""")

	write_function(f"{root}/body/seat_tick", f"""
# The seat is dropped on the point the caller computed, in front of the mannequin eyes
tp @s ~ ~ ~
execute on passengers run function {root}/body/read_player
execute on passengers unless entity @s[tag={tag}.look] run function {root}/body/aim

# A rider holding both the click and the look, a solo player for instance, aims the mannequin from here
execute on passengers if entity @s[tag={tag}.look] rotated as @s as @n[type=mannequin,tag={tag}.body,{same_group},distance=..{RADIUS}] run function {root}/body/aim

# Tells the caller the seat was found, whether or not it carries anyone
return 1
""")

	write_function(f"{root}/body/find_seat", f"""
# A teleport carries the mannequin and its passengers but never its seat, so the seat is brought back by hand
execute store success score #{mode.id}_seat {ns}.data as @e[type=item_display,tag={tag}.seat,{same_group}] run function {root}/body/seat_tick
execute if score #{mode.id}_seat {ns}.data matches 0 summon minecraft:item_display run function {root}/body/new_seat
""")

	read_inputs: str = "\n".join(
		f"execute if entity @s[tag={tag}.{name},predicate={ns}:input/{CRAWL_KEY if name == 'crawl' else name}] run scoreboard players add #{mode.id}_in_{name} {ns}.data 1"
		for name in INPUTS
	)
	write_function(f"{root}/body/read_player", f"""
scoreboard players add #{mode.id}_crew {ns}.data 1

# Report the keys it is holding down (crawl has no vanilla key, it is read on CRAWL_KEY)
{read_inputs}
""")

	write_function(f"{root}/body/remount", f"""
# The only pass still scanning the players, and it only runs while someone is off its vehicle
execute as @a[tag={tag},{same_group},distance=..{RADIUS}] run function {root}/body/mount_player

# Still short, so someone was left behind by a teleport: the whole player list is searched this time
execute if score #{mode.id}_crew {ns}.data matches ..{mode.group_size - 1} as @a[tag={tag},{same_group}] run function {root}/body/mount_player
""")

	write_function(f"{root}/body/mount_player", f"""
execute on vehicle run return 0
execute if entity @s[tag={tag}.click] run return run function {root}/body/mount_seat
ride @s mount @n[type=mannequin,tag={tag}.body,{same_group},distance=..0.5]
function {root}/body/read_player
""")

	write_function(f"{root}/body/mount_seat", f"""
# Another group may be within reach at this radius, so the seat is picked by its group
ride @s mount @n[type=item_display,tag={tag}.seat,{same_group},distance=..{RADIUS}]
function {root}/body/read_player
""")

	write_function(f"{root}/body/update_pose", f"""
scoreboard players operation @s {tag}.pose = #{mode.id}_pose {ns}.data
execute if score #{mode.id}_pose {ns}.data matches 0 run data modify entity @s pose set value "standing"
execute if score #{mode.id}_pose {ns}.data matches 1 run data modify entity @s pose set value "crouching"
execute if score #{mode.id}_pose {ns}.data matches 2 run data modify entity @s pose set value "swimming"
""")


def phase_help_message(phase: Phase, group_size: int) -> str:
	""" Build the tellraw listing the command set of every slot for a phase

	Returns:
		The JSON text component, ready to be pasted in a tellraw

	>>> from .phases import PHASES
	>>> '"Joueur 1 : "' in phase_help_message(PHASES[1], 4)
	True
	"""
	components: list[dict[str, str]] = [{"text": "\n"}]
	for slot in range(1, group_size + 1):
		actions: str = " / ".join(action.display for action in actions_of_slot(phase, slot)) or "Rien du tout"
		components.append({"text": f"Joueur {slot} : ", "color": "yellow"})
		components.append({"text": f"{actions}\n", "color": "white"})
	return json.dumps(components, ensure_ascii=False)


def generate_phase_functions(mode: CrewMode) -> None:
	""" Write the phase functions applied on one mannequin, and their player pass. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{mode.path}"
	tag: str = f"{ns}.{mode.id}"
	same_group: str = f"predicate={ns}:{mode.path}/same_group"

	write_function(f"{root}/body/deal_click", """
# Riding counts as being in the air which divides the mining speed by five
attribute @s minecraft:block_break_speed base set 5
attribute @s minecraft:entity_interaction_range base reset
attribute @s minecraft:block_interaction_range base reset
""")

	for index, phase in enumerate(mode.phases):
		write_function(f"{root}/body/set_phase/{phase.id}", f"""
# Idempotent, so the command block of the part can keep firing on the group standing on it
execute if score @s {tag}.phase matches {index} run return 0
function {root}/body/enter_phase/{phase.id}
""")

		write_function(f"{root}/body/enter_phase/{phase.id}", f"""
# Remember which part this group is running
scoreboard players set @s {tag}.phase {index}
scoreboard players operation #{mode.id}_group {ns}.data = @s {tag}.group

# Single scan of the group: every player is dealt its own command set, then put back on the right vehicle
execute as @a[tag={tag},{same_group},distance=..{RADIUS}] run function {root}/body/deal/{phase.id}
function {root}/body/remount

# The help is read by the whole group and by anyone watching them
tellraw @a[distance=..{RADIUS}] {phase_help_message(phase, mode.group_size)}
""")

		clear_tags: str = "\n".join(f"tag @s remove {tag}.{action.name}" for action in ACTIONS)
		give_tags: str = "\n".join(
			f"execute if score @s {tag} matches {slot} run tag @s add {tag}.{action.name}"
			for action in ACTIONS
			for slot in phase.bindings.get(action.name, ())
		)
		solo_tags: str = "\n".join(
			f"execute if score {mode.solo_flag} matches 1 run tag @s add {tag}.{action.name}"
			for action in ACTIONS
			if mode.solo_flag and action.name in phase.bindings
		)
		write_function(f"{root}/body/deal/{phase.id}", f"""
# The click holder rides its own seat, so a new command set can mean a new vehicle
execute if predicate {ns}:riding run ride @s dismount

# Clear the previous command set
{clear_tags}

# Give the command set of this part
{give_tags}
{solo_tags}

# Only the click holder keeps a body able to touch the world
attribute @s minecraft:block_break_speed base reset
attribute @s minecraft:entity_interaction_range base set 0
attribute @s minecraft:block_interaction_range base set 0
execute if entity @s[tag={tag}.click] run function {root}/body/deal_click

# Announce the new command set
title @s title {json.dumps({"text": phase.display, "color": "gold"}, ensure_ascii=False)}
title @s subtitle {json.dumps({"text": "Nouveau set de commandes", "color": "gray"}, ensure_ascii=False)}
playsound block.note_block.pling master @s
""")

	apply_phase: str = "\n".join(
		f"execute if score @s {tag}.phase matches {index} run return run function {root}/body/enter_phase/{phase.id}"
		for index, phase in enumerate(mode.phases)
	)
	write_function(f"{root}/body/apply_phase", f"""
# Deal the current command set again, even when the group is already in that part
{apply_phase}
""")

	write_function(f"{root}/body/next_phase", f"""
scoreboard players add @s {tag}.phase 1
execute if score @s {tag}.phase matches {len(mode.phases)}.. run scoreboard players set @s {tag}.phase 0
function {root}/body/apply_phase
""")

	write_function(f"{root}/body/shuffle_slots", f"""
# Everyone of this group moves to the next slot, then the current command set is dealt again
scoreboard players operation #{mode.id}_group {ns}.data = @s {tag}.group
scoreboard players add @a[tag={tag},{same_group},distance=..{RADIUS}] {tag} 1
scoreboard players set @a[tag={tag},scores={{{tag}={mode.group_size + 1}..}},{same_group},distance=..{RADIUS}] {tag} 1
function {root}/body/apply_phase
""")


def generate_dispatchers(mode: CrewMode) -> None:
	""" Write the admin commands, in two flavours: every group at once, or only the group standing here. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{mode.path}"
	tag: str = f"{ns}.{mode.id}"
	targets: list[tuple[str, str]] = [("next_phase", "body/next_phase"), ("shuffle_slots", "body/shuffle_slots")]
	targets += [(f"set_phase/{phase.id}", f"body/set_phase/{phase.id}") for phase in mode.phases]

	for name, called in targets:
		write_function(f"{root}/{name}", f"""
# Every group at once, use the here/ version to handle a single one
execute as @e[type=mannequin,tag={tag}.body] at @s run function {root}/{called}
""")
		write_function(f"{root}/here/{name}", f"""
# Only the group whose mannequin is the nearest one
execute as @n[type=mannequin,tag={tag}.body,distance=..{TRIGGER_RADIUS}] at @s run function {root}/{called}
""")

