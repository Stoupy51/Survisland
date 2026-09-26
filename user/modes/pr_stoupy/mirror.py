""" Trial "Miroirs": two players, each one followed by a mannequin that mirrors their moves across a plane.

The plane goes through the start command block, normal to the axis given to start.
Every tick the displacement of each player is mirrored and written as the Motion of its mannequin,
so walls, stairs and pressure plates act on the mannequin like on any mob.
A frozen mannequin ignores its player, and the gap built up meanwhile is the whole puzzle.
"""
# ruff: noqa: E501
# Imports
from stewbeet import JsonDict, Mem, Predicate, set_json_encoder, write_function

from user.utils.player_head import PLAYER_HEAD_LOOT_TABLE

from .shared import LAB

# Constants
MODE: str = "pr_mirror"
""" Suffix of the tags, objectives and fake players of the trial. """

START_RADIUS: int = 3
""" Radius around the start command block where the two players are taken. """

JUMP_TRIGGER: int = 100
""" Rise of the player in one tick, in thousandths of a block, read as the start of a jump. """

HOLOGRAM_TEXTURE: str = "survisland:entity/pr_stoupy/hologram"
""" Skin shown while frozen, recognized by the entity shader through the signature of its first texel. """

FREEZE_ITEM: str = 'minecraft:warped_fungus_on_a_stick[custom_data={survisland:{mirror_freeze:true}},item_model="minecraft:blue_ice",item_name={"text":"Figer le reflet","color":"aqua"},lore=[{"text":"Clic droit : fige ou libère ton reflet","color":"gray","italic":false}]]'
""" Item whose right click freezes or releases the mannequin of its holder, hooked in utils/right_click. """


# Functions
def main() -> None:
	""" Write every function of the mirror trial. """
	generate_predicates()
	generate_start()
	generate_tick()
	generate_freeze()
	generate_stop()


def generate_predicates() -> None:
	""" Write the predicate pairing a player with its mannequin, both carrying the same slot. """
	ns: str = Mem.ctx.project_id
	slot: JsonDict = {"type": "minecraft:score", "target": {"type": "minecraft:fixed", "name": f"#{MODE}_slot"}, "score": f"{ns}.data"}
	same_slot: JsonDict = {"condition": "minecraft:entity_scores", "entity": "this", "scores": {f"{ns}.{MODE}": {"min": slot, "max": slot}}}
	Mem.ctx.data[ns].predicates[f"{LAB}/mirror/same_slot"] = set_json_encoder(Predicate(same_slot), max_level=-1)


def generate_start() -> None:
	""" Write the start, taking the two nearest free players and summoning their reflections. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/mirror"
	tag: str = f"{ns}.{MODE}"
	free_player: str = f"tag=!{tag},distance=..{START_RADIUS},gamemode=!creative,gamemode=!spectator"

	write_function(f"{root}/start", f"""
# Safe to fire every tick: one session at a time, and only with two free players standing here
execute if score #{MODE}_running {ns}.data matches 1 run return 0
execute store result score #{MODE}_free {ns}.data if entity @a[{free_player}]
execute if score #{MODE}_free {ns}.data matches ..1 run return 0

scoreboard objectives add {tag} dummy
scoreboard objectives add {tag}.x dummy
scoreboard objectives add {tag}.y dummy
scoreboard objectives add {tag}.z dummy
scoreboard objectives add {tag}.frozen dummy
scoreboard objectives add {tag}.moving dummy
scoreboard objectives add {tag}.yaw dummy
scoreboard objectives add {tag}.pitch dummy

# The mirror plane goes through this block, normal to the given axis
$data modify storage {ns}:{MODE} axis set value "$(axis)"
scoreboard players set #{MODE}_flip_x {ns}.data 1
scoreboard players set #{MODE}_flip_z {ns}.data 1
execute if data storage {ns}:{MODE} {{axis:"x"}} run scoreboard players set #{MODE}_flip_x {ns}.data -1
execute if data storage {ns}:{MODE} {{axis:"z"}} run scoreboard players set #{MODE}_flip_z {ns}.data -1
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function {root}/store_plane

scoreboard players set #{MODE}_slot_counter {ns}.data 0
execute as @a[{free_player},limit=2,sort=nearest] at @s run function {root}/enroll_player
scoreboard players set #{MODE}_running {ns}.data 1
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/store_plane", f"""
function #bs.position:get_pos {{scale:1000}}
scoreboard players operation #{MODE}_plane_x {ns}.data = @s bs.pos.x
scoreboard players operation #{MODE}_plane_z {ns}.data = @s bs.pos.z
kill @s
""")

	write_function(f"{root}/enroll_player", f"""
scoreboard players add #{MODE}_slot_counter {ns}.data 1
scoreboard players operation @s {tag} = #{MODE}_slot_counter {ns}.data
tag @s add {tag}
give @s {FREEZE_ITEM}

# The first displacement is measured from here
function #bs.position:get_pos {{scale:1000}}
scoreboard players operation @s {tag}.x = @s bs.pos.x
scoreboard players operation @s {tag}.y = @s bs.pos.y
scoreboard players operation @s {tag}.z = @s bs.pos.z

tag @s add {tag}.new
execute summon minecraft:mannequin run function {root}/new_body
tag @s remove {tag}.new
""")

	write_function(f"{root}/new_body", f"""
tag @s add {tag}.body
tag @s add {tag}.fresh
data merge entity @s {{immovable:0b,hide_description:1b,Invulnerable:1b}}
scoreboard players operation @s {tag} = #{MODE}_slot_counter {ns}.data
scoreboard players set @s {tag}.frozen 0
scoreboard players set @s {tag}.moving 0

# Same skin as its player, borrowed through a player head
execute as @a[tag={tag}.new,limit=1] run loot replace entity @n[type=mannequin,tag={tag}.fresh] weapon.mainhand loot {PLAYER_HEAD_LOOT_TABLE}
data modify entity @s profile set from entity @s equipment.mainhand.components."minecraft:profile"
item replace entity @s weapon.mainhand with minecraft:air
tag @s remove {tag}.fresh

function {root}/place_body
""")

	write_function(f"{root}/place_body", f"""
# @s is a mannequin, sent to the reflection of the player tagged {tag}.new
scoreboard players operation @s bs.pos.x = @a[tag={tag}.new,limit=1] {tag}.x
scoreboard players operation @s bs.pos.y = @a[tag={tag}.new,limit=1] {tag}.y
scoreboard players operation @s bs.pos.z = @a[tag={tag}.new,limit=1] {tag}.z
execute if score #{MODE}_flip_x {ns}.data matches -1 run function {root}/reflect_x
execute if score #{MODE}_flip_z {ns}.data matches -1 run function {root}/reflect_z
function #bs.position:set_pos {{scale:0.001}}
scoreboard players set @s {tag}.yaw 2147483647
""")

	for axis in ("x", "z"):
		write_function(f"{root}/reflect_{axis}", f"""
# pos = 2 * plane - pos
scoreboard players operation @s bs.pos.{axis} *= #-1 {ns}.data
scoreboard players operation #{MODE}_twice {ns}.data = #{MODE}_plane_{axis} {ns}.data
scoreboard players operation #{MODE}_twice {ns}.data *= #2 {ns}.data
scoreboard players operation @s bs.pos.{axis} += #{MODE}_twice {ns}.data
""")

	write_function(f"{root}/reset", f"""
# Send every mannequin back to the reflection of its player, released
execute as @a[tag={tag}] at @s run function {root}/reset_player
""")

	write_function(f"{root}/reset_player", f"""
function #bs.position:get_pos {{scale:1000}}
scoreboard players operation @s {tag}.x = @s bs.pos.x
scoreboard players operation @s {tag}.y = @s bs.pos.y
scoreboard players operation @s {tag}.z = @s bs.pos.z
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
tag @s add {tag}.new
execute as @e[type=mannequin,tag={tag}.body,predicate={ns}:{LAB}/mirror/same_slot] run function {root}/reset_body
tag @s remove {tag}.new
""")

	write_function(f"{root}/reset_body", f"""
execute if score @s {tag}.frozen matches 1 run function {root}/unfreeze
function {root}/place_body
""")


def generate_tick() -> None:
	""" Write the per tick loop: each player measures its displacement and drives its own mannequin. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/mirror"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/tick", f"""
scoreboard players set #{MODE}_alive {ns}.data 0
execute as @a[tag={tag}] at @s run function {root}/player_tick
execute if score #{MODE}_alive {ns}.data matches 0 run return run function {root}/stop
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/player_tick", f"""
scoreboard players add #{MODE}_alive {ns}.data 1
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}

# Displacement since the previous tick, in thousandths of a block
function #bs.position:get_pos {{scale:1000}}
scoreboard players operation #{MODE}_dx {ns}.data = @s bs.pos.x
scoreboard players operation #{MODE}_dy {ns}.data = @s bs.pos.y
scoreboard players operation #{MODE}_dz {ns}.data = @s bs.pos.z
scoreboard players operation #{MODE}_dx {ns}.data -= @s {tag}.x
scoreboard players operation #{MODE}_dy {ns}.data -= @s {tag}.y
scoreboard players operation #{MODE}_dz {ns}.data -= @s {tag}.z
scoreboard players operation @s {tag}.x = @s bs.pos.x
scoreboard players operation @s {tag}.y = @s bs.pos.y
scoreboard players operation @s {tag}.z = @s bs.pos.z

# Mirrored displacement and aim (yaw becomes -yaw across x, 180 - yaw across z)
scoreboard players operation #{MODE}_dx {ns}.data *= #{MODE}_flip_x {ns}.data
scoreboard players operation #{MODE}_dz {ns}.data *= #{MODE}_flip_z {ns}.data
function #bs.position:get_rot {{scale:100}}
scoreboard players operation #{MODE}_yaw {ns}.data = @s bs.rot.h
scoreboard players operation #{MODE}_pitch {ns}.data = @s bs.rot.v
execute if score #{MODE}_flip_x {ns}.data matches -1 run scoreboard players operation #{MODE}_yaw {ns}.data *= #-1 {ns}.data
execute if score #{MODE}_flip_z {ns}.data matches -1 run function {root}/reflect_yaw_z

execute as @e[type=mannequin,tag={tag}.body,predicate={ns}:{LAB}/mirror/same_slot] run function {root}/drive
""")

	write_function(f"{root}/reflect_yaw_z", f"""
scoreboard players operation #{MODE}_yaw {ns}.data *= #-1 {ns}.data
scoreboard players operation #{MODE}_yaw {ns}.data += #18000 {ns}.data
""")

	write_function(f"{root}/drive", f"""
execute if score @s {tag}.frozen matches 1 run return 0

# A rise starting from the ground is a jump, gravity handles the rest of the arc
execute if score #{MODE}_dy {ns}.data matches {JUMP_TRIGGER}.. if predicate {ns}:on_ground run data modify entity @s Motion[1] set value 0.42d

# Turn only when the aim changed, the rotate call gives the head the angle written in the body
execute unless score #{MODE}_yaw {ns}.data = @s {tag}.yaw run function {root}/aim
execute unless score #{MODE}_pitch {ns}.data = @s {tag}.pitch run function {root}/aim

# Writing Motion costs a full entity save, so a still player writes its stop once and then nothing
scoreboard players set #{MODE}_moving {ns}.data 0
execute unless score #{MODE}_dx {ns}.data matches 0 run scoreboard players set #{MODE}_moving {ns}.data 1
execute unless score #{MODE}_dz {ns}.data matches 0 run scoreboard players set #{MODE}_moving {ns}.data 1
execute if score #{MODE}_moving {ns}.data matches 0 if score @s {tag}.moving matches 0 run return 0
scoreboard players operation @s {tag}.moving = #{MODE}_moving {ns}.data
execute store result entity @s Motion[0] double 0.001 run scoreboard players get #{MODE}_dx {ns}.data
execute store result entity @s Motion[2] double 0.001 run scoreboard players get #{MODE}_dz {ns}.data
""")

	write_function(f"{root}/aim", f"""
scoreboard players operation @s {tag}.yaw = #{MODE}_yaw {ns}.data
scoreboard players operation @s {tag}.pitch = #{MODE}_pitch {ns}.data
execute store result entity @s Rotation[0] float 0.01 run scoreboard players get #{MODE}_yaw {ns}.data
execute store result entity @s Rotation[1] float 0.01 run scoreboard players get #{MODE}_pitch {ns}.data
execute rotated as @s run rotate @s ~ ~
""")


def generate_freeze() -> None:
	""" Write the freeze toggle, called by the right click of the freeze item. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/mirror"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/toggle_freeze", f"""
# @s is the player who right clicked, only its own reflection answers
execute unless entity @s[tag={tag}] run return fail
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
execute as @e[type=mannequin,tag={tag}.body,predicate={ns}:{LAB}/mirror/same_slot] run function {root}/toggle_body
""")

	write_function(f"{root}/toggle_body", f"""
execute if score @s {tag}.frozen matches 1 run return run function {root}/unfreeze
function {root}/freeze
""")

	write_function(f"{root}/freeze", f"""
scoreboard players set @s {tag}.frozen 1
scoreboard players set @s {tag}.moving 0
data modify entity @s Motion[0] set value 0.0d
data modify entity @s Motion[2] set value 0.0d
data modify entity @s profile.texture set value "{HOLOGRAM_TEXTURE}"
execute at @s run playsound minecraft:block.beacon.deactivate master @a[distance=..48] ~ ~ ~ 1 1.6
execute at @s run particle minecraft:electric_spark ~ ~1 ~ 0.3 0.6 0.3 0.1 30
title @a[tag={tag},predicate={ns}:{LAB}/mirror/same_slot] actionbar {{"text":"Reflet figé","color":"aqua"}}
""")

	write_function(f"{root}/unfreeze", f"""
scoreboard players set @s {tag}.frozen 0
data remove entity @s profile.texture
execute at @s run playsound minecraft:block.beacon.activate master @a[distance=..48] ~ ~ ~ 1 1.6
title @a[tag={tag},predicate={ns}:{LAB}/mirror/same_slot] actionbar {{"text":"Reflet libéré","color":"green"}}
""")


def generate_stop() -> None:
	""" Write the stop, and the reward given at the exit of the room. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/mirror"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/stop", f"""
kill @e[type=mannequin,tag={tag}.body]
clear @a[tag={tag}] *[custom_data~{{survisland:{{mirror_freeze:true}}}}]
tag @a remove {tag}
scoreboard players set #{MODE}_running {ns}.data 0
schedule clear {root}/tick
""")

	write_function(f"{root}/here/reward", f"""
# One shot at the exit: the nearest player gets the star, then the reflections go away
execute as @p[distance=..5,gamemode=!spectator] run function {ns}:{LAB}/give_star {{trial:"Les miroirs"}}
function {root}/stop
""")

