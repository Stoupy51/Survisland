""" Trial "Miroirs": two players, each one followed by a mannequin that mirrors their moves across a plane.

The plane goes through the start command block, normal to the axis given to start.
Every tick the displacement of each player is mirrored and written as the Motion of its mannequin,
so walls, stairs and pressure plates act on the mannequin like on any mob.
A frozen mannequin ignores its player, and the gap built up meanwhile is the whole puzzle.

Each start opens a session anchored on its command block, carried as a score by its two players and their mannequins,
so several copies of the room can run at the same time. Each player also carries its own plane and axis.
"""
# ruff: noqa: E501
# Imports
from stewbeet import Mem, write_function

from user.utils.player_head import PLAYER_HEAD_LOOT_TABLE

from .shared import (
	BACK,
	FORGET_BACK,
	LAB,
	ON_START_PAD,
	SEND_BACK,
	START_RADIUS,
	STORE_TP,
	TELEPORT,
	require_players,
	write_match_predicate,
)

# Constants
MODE: str = "pr_mirror"
""" Suffix of the tags, objectives and fake players of the trial. """

REWARD_RADIUS: int = 5
""" Radius around the reward command block where the player receiving the star is looked for. """

JUMP_TRIGGER: int = 100
""" Rise of the player in one tick, in thousandths of a block, read as the start of a jump. """

HOLOGRAM_TEXTURE: str = "survisland:entity/pr_stoupy/hologram"
""" Skin shown while frozen, recognized by the entity shader through the signature of its first texel. """

FREEZE_ITEM: str = 'minecraft:warped_fungus_on_a_stick[custom_data={survisland:{mirror_freeze:true}},item_model="minecraft:blue_ice",item_name={"text":"Figer le reflet","color":"aqua"},lore=[{"text":"Clic droit : fige ou libère ton reflet","color":"gray","italic":false}]]'
""" Item whose right click freezes or releases the mannequin of its holder, hooked in utils/right_click. """


# Functions
def main() -> None:
	""" Write every function of the mirror trial. """
	ns: str = Mem.ctx.project_id
	tag: str = f"{ns}.{MODE}"
	same_session: str = write_match_predicate(f"{LAB}/mirror/same_session", {f"{tag}.session": f"#{MODE}_session"})
	same_pair: str = write_match_predicate(f"{LAB}/mirror/same_pair", {f"{tag}.session": f"#{MODE}_session", tag: f"#{MODE}_slot"})
	generate_start(same_pair)
	generate_tick(same_pair)
	generate_freeze(same_pair)
	generate_stop(same_session)


def generate_start(same_pair: str) -> None:
	""" Write the start, taking the two nearest free players and summoning their reflections. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/mirror"
	tag: str = f"{ns}.{MODE}"
	free_player: str = f"tag=!{tag},tag=!{BACK},distance=..{START_RADIUS},{ON_START_PAD},gamemode=!creative,gamemode=!spectator"
	objectives: str = "\n".join(f"scoreboard objectives add {tag}{suffix} dummy" for suffix in ("", ".session", ".x", ".y", ".z", ".plane_x", ".plane_z", ".flip_x", ".flip_z", ".frozen", ".moving", ".yaw", ".pitch", ".sneak"))

	write_function(f"{root}/start", f"""
# Safe to fire every tick: one session per command block, and only with two free players on the start pads
{FORGET_BACK}
execute if entity @e[type=minecraft:marker,tag={tag}.anchor,distance=..1] run return 0
execute store result score #{MODE}_free {ns}.data if entity @a[{free_player}]
{require_players(f"#{MODE}_free {ns}.data", 2)}
{objectives}

# The mirror plane goes through this block, normal to the given axis
$data modify storage {ns}:{MODE} axis set value "$(axis)"
scoreboard players set #{MODE}_flip_x {ns}.data 1
scoreboard players set #{MODE}_flip_z {ns}.data 1
execute if data storage {ns}:{MODE} {{axis:"x"}} run scoreboard players set #{MODE}_flip_x {ns}.data -1
execute if data storage {ns}:{MODE} {{axis:"z"}} run scoreboard players set #{MODE}_flip_z {ns}.data -1
scoreboard players add #{MODE}_session_counter {ns}.data 1
scoreboard players operation #{MODE}_session {ns}.data = #{MODE}_session_counter {ns}.data
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function {root}/new_anchor

# $(tp) moves each player from where it stands, "" to leave them on the pads
scoreboard players set #{MODE}_slot_counter {ns}.data 0
tag @a[{free_player},limit=2,sort=nearest] add {tag}.entering
{STORE_TP}
execute as @a[tag={tag}.entering] at @s run {TELEPORT}
execute as @a[tag={tag}.entering] at @s run function {root}/enroll_player
tag @a remove {tag}.entering
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/new_anchor", f"""
tag @s add {tag}.anchor
scoreboard players operation @s {tag}.session = #{MODE}_session {ns}.data
function #bs.position:get_pos {{scale:1000}}
scoreboard players operation #{MODE}_plane_x {ns}.data = @s bs.pos.x
scoreboard players operation #{MODE}_plane_z {ns}.data = @s bs.pos.z
""")

	write_function(f"{root}/enroll_player", f"""
scoreboard players add #{MODE}_slot_counter {ns}.data 1
scoreboard players operation @s {tag} = #{MODE}_slot_counter {ns}.data
scoreboard players operation @s {tag}.session = #{MODE}_session {ns}.data
scoreboard players operation @s {tag}.plane_x = #{MODE}_plane_x {ns}.data
scoreboard players operation @s {tag}.plane_z = #{MODE}_plane_z {ns}.data
scoreboard players operation @s {tag}.flip_x = #{MODE}_flip_x {ns}.data
scoreboard players operation @s {tag}.flip_z = #{MODE}_flip_z {ns}.data
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
scoreboard players operation @s {tag}.session = #{MODE}_session {ns}.data
scoreboard players set @s {tag}.frozen 0
scoreboard players set @s {tag}.moving 0
scoreboard players set @s {tag}.sneak 0

# Same skin as its player, borrowed through a player head
execute as @a[tag={tag}.new,limit=1] run loot replace entity @n[type=mannequin,tag={tag}.fresh] weapon.mainhand loot {PLAYER_HEAD_LOOT_TABLE}
data modify entity @s profile set from entity @s equipment.mainhand.components."minecraft:profile"
item replace entity @s weapon.mainhand with minecraft:air
tag @s remove {tag}.fresh

function {root}/place_body
""")

	write_function(f"{root}/place_body", f"""
# @s is a mannequin, sent to the reflection of the player tagged {tag}.new across the plane of that player
scoreboard players operation @s bs.pos.x = @a[tag={tag}.new,limit=1] {tag}.x
scoreboard players operation @s bs.pos.y = @a[tag={tag}.new,limit=1] {tag}.y
scoreboard players operation @s bs.pos.z = @a[tag={tag}.new,limit=1] {tag}.z
scoreboard players operation #{MODE}_plane_x {ns}.data = @a[tag={tag}.new,limit=1] {tag}.plane_x
scoreboard players operation #{MODE}_plane_z {ns}.data = @a[tag={tag}.new,limit=1] {tag}.plane_z
execute if entity @a[tag={tag}.new,scores={{{tag}.flip_x=-1}}] run function {root}/reflect_x
execute if entity @a[tag={tag}.new,scores={{{tag}.flip_z=-1}}] run function {root}/reflect_z
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

	write_function(f"{root}/here/reset", f"""
# The session of the nearest player of the trial: every reflection goes back in front of its player, released
scoreboard players operation #{MODE}_session {ns}.data = @p[tag={tag}] {tag}.session
execute as @a[tag={tag}] if score @s {tag}.session = #{MODE}_session {ns}.data at @s run function {root}/reset_player
""")

	write_function(f"{root}/reset_player", f"""
function #bs.position:get_pos {{scale:1000}}
scoreboard players operation @s {tag}.x = @s bs.pos.x
scoreboard players operation @s {tag}.y = @s bs.pos.y
scoreboard players operation @s {tag}.z = @s bs.pos.z
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
tag @s add {tag}.new
execute as @e[type=mannequin,tag={tag}.body,{same_pair}] run function {root}/reset_body
tag @s remove {tag}.new
""")

	write_function(f"{root}/reset_body", f"""
execute if score @s {tag}.frozen matches 1 run function {root}/unfreeze
function {root}/place_body
""")


def generate_tick(same_pair: str) -> None:
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
scoreboard players operation #{MODE}_session {ns}.data = @s {tag}.session
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
scoreboard players operation #{MODE}_dx {ns}.data *= @s {tag}.flip_x
scoreboard players operation #{MODE}_dz {ns}.data *= @s {tag}.flip_z
function #bs.position:get_rot {{scale:100}}
scoreboard players operation #{MODE}_yaw {ns}.data = @s bs.rot.h
scoreboard players operation #{MODE}_pitch {ns}.data = @s bs.rot.v
execute if score @s {tag}.flip_x matches -1 run scoreboard players operation #{MODE}_yaw {ns}.data *= #-1 {ns}.data
execute if score @s {tag}.flip_z matches -1 run function {root}/reflect_yaw_z
execute store success score #{MODE}_sneak {ns}.data if entity @s[predicate={ns}:is_sneaking]
execute store success score #{MODE}_climb {ns}.data if block ~ ~ ~ #minecraft:climbable

execute as @e[type=mannequin,tag={tag}.body,{same_pair}] run function {root}/drive
""")

	write_function(f"{root}/reflect_yaw_z", f"""
scoreboard players operation #{MODE}_yaw {ns}.data *= #-1 {ns}.data
scoreboard players operation #{MODE}_yaw {ns}.data += #18000 {ns}.data
""")

	write_function(f"{root}/drive", f"""
execute if score @s {tag}.frozen matches 1 run return 0

# A climbing player lends its vertical move as is, Motion being applied before gravity, so nothing needs to be climbed on this side
execute if score #{MODE}_climb {ns}.data matches 1 store result entity @s Motion[1] double 0.001 run scoreboard players get #{MODE}_dy {ns}.data

# Otherwise a rise starting from the ground is a jump, gravity handles the rest of the arc
execute if score #{MODE}_climb {ns}.data matches 0 if score #{MODE}_dy {ns}.data matches {JUMP_TRIGGER}.. if predicate {ns}:on_ground run data modify entity @s Motion[1] set value 0.42d

# Crouch or stand up only when the player just did
execute unless score #{MODE}_sneak {ns}.data = @s {tag}.sneak run function {root}/update_pose

# Turn only when the aim changed
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

	write_function(f"{root}/update_pose", f"""
scoreboard players operation @s {tag}.sneak = #{MODE}_sneak {ns}.data
execute if score #{MODE}_sneak {ns}.data matches 0 run data modify entity @s pose set value "standing"
execute if score #{MODE}_sneak {ns}.data matches 1 run data modify entity @s pose set value "crouching"
""")

	write_function(f"{root}/aim", f"""
# rotate gives the head the angle written in the body, its ~ being relative to the rotation of the source
scoreboard players operation @s {tag}.yaw = #{MODE}_yaw {ns}.data
scoreboard players operation @s {tag}.pitch = #{MODE}_pitch {ns}.data
execute store result entity @s Rotation[0] float 0.01 run scoreboard players get #{MODE}_yaw {ns}.data
execute store result entity @s Rotation[1] float 0.01 run scoreboard players get #{MODE}_pitch {ns}.data
execute rotated as @s run rotate @s ~ ~
""")


def generate_freeze(same_pair: str) -> None:
	""" Write the freeze toggle, called by the right click of the freeze item. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/mirror"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/toggle_freeze", f"""
# @s is the player who right clicked, only its own reflection answers
execute unless entity @s[tag={tag}] run return fail
scoreboard players operation #{MODE}_session {ns}.data = @s {tag}.session
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
execute as @e[type=mannequin,tag={tag}.body,{same_pair}] run function {root}/toggle_body
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
execute at @s run playsound minecraft:block.beacon.deactivate ambient @a[distance=..48] ~ ~ ~ 1 1.6
execute at @s run particle minecraft:electric_spark ~ ~1 ~ 0.3 0.6 0.3 0.1 30
title @a[tag={tag},{same_pair}] actionbar {{"text":"Reflet figé","color":"aqua"}}
""")

	write_function(f"{root}/unfreeze", f"""
scoreboard players set @s {tag}.frozen 0
data remove entity @s profile.texture
execute at @s run playsound minecraft:block.beacon.activate ambient @a[distance=..48] ~ ~ ~ 1 1.6
title @a[tag={tag},{same_pair}] actionbar {{"text":"Reflet libéré","color":"green"}}
""")


def generate_stop(same_session: str) -> None:
	""" Write the stops, of one session or of all of them, and the reward given at the exit of the room. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/mirror"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/stop_session", f"""
# The session held in #{MODE}_session: reflections, freeze items, player tags and its anchor, unless won
kill @e[type=mannequin,tag={tag}.body,{same_session}]
kill @e[type=minecraft:marker,tag={tag}.anchor,tag=!{tag}.done,{same_session}]
clear @a[tag={tag},{same_session}] *[custom_data~{{survisland:{{mirror_freeze:true}}}}]
execute as @a[tag={tag},{same_session}] run {SEND_BACK}
tag @a[tag={tag},{same_session}] remove {tag}
""")

	write_function(f"{root}/here/stop", f"""
# The session of the nearest player of the trial
scoreboard players operation #{MODE}_session {ns}.data = @p[tag={tag}] {tag}.session
function {root}/stop_session
""")

	write_function(f"{root}/here/reward", f"""
# One shot at the exit: the nearest player gets the star, then the reflections of its session go away
# The anchor stays as won on its start block, which cannot start again until here/clear removes it
execute as @p[distance=..{REWARD_RADIUS},gamemode=!spectator] run function {ns}:{LAB}/give_star {{trial:"Les miroirs"}}
execute unless entity @p[tag={tag},distance=..{REWARD_RADIUS}] run return 0
scoreboard players operation #{MODE}_session {ns}.data = @p[tag={tag},distance=..{REWARD_RADIUS}] {tag}.session
tag @e[type=minecraft:marker,tag={tag}.anchor,{same_session}] add {tag}.done
function {root}/stop_session
""")

	write_function(f"{root}/stop", f"""
# Every session, everywhere, won rooms staying locked
kill @e[type=mannequin,tag={tag}.body]
kill @e[type=minecraft:marker,tag={tag}.anchor,tag=!{tag}.done]
clear @a[tag={tag}] *[custom_data~{{survisland:{{mirror_freeze:true}}}}]
execute as @a[tag={tag}] run {SEND_BACK}
tag @a remove {tag}
schedule clear {root}/tick
""")

