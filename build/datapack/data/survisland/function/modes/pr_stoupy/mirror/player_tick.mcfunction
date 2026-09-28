
#> survisland:modes/pr_stoupy/mirror/player_tick
#
# @executed	as @a[tag=survisland.pr_mirror] & at @s
#
# @within	survisland:modes/pr_stoupy/mirror/tick [ as @a[tag=survisland.pr_mirror] & at @s ]
#

scoreboard players add #pr_mirror_alive survisland.data 1
scoreboard players operation #pr_mirror_session survisland.data = @s survisland.pr_mirror.session
scoreboard players operation #pr_mirror_slot survisland.data = @s survisland.pr_mirror

# Displacement since the previous tick, in thousandths of a block
function #bs.position:get_pos {scale:1000}
scoreboard players operation #pr_mirror_dx survisland.data = @s bs.pos.x
scoreboard players operation #pr_mirror_dy survisland.data = @s bs.pos.y
scoreboard players operation #pr_mirror_dz survisland.data = @s bs.pos.z
scoreboard players operation #pr_mirror_dx survisland.data -= @s survisland.pr_mirror.x
scoreboard players operation #pr_mirror_dy survisland.data -= @s survisland.pr_mirror.y
scoreboard players operation #pr_mirror_dz survisland.data -= @s survisland.pr_mirror.z
scoreboard players operation @s survisland.pr_mirror.x = @s bs.pos.x
scoreboard players operation @s survisland.pr_mirror.y = @s bs.pos.y
scoreboard players operation @s survisland.pr_mirror.z = @s bs.pos.z

# Mirrored displacement and aim (yaw becomes -yaw across x, 180 - yaw across z)
scoreboard players operation #pr_mirror_dx survisland.data *= @s survisland.pr_mirror.flip_x
scoreboard players operation #pr_mirror_dz survisland.data *= @s survisland.pr_mirror.flip_z
function #bs.position:get_rot {scale:100}
scoreboard players operation #pr_mirror_yaw survisland.data = @s bs.rot.h
scoreboard players operation #pr_mirror_pitch survisland.data = @s bs.rot.v
execute if score @s survisland.pr_mirror.flip_x matches -1 run scoreboard players operation #pr_mirror_yaw survisland.data *= #-1 survisland.data
execute if score @s survisland.pr_mirror.flip_z matches -1 run function survisland:modes/pr_stoupy/mirror/reflect_yaw_z
execute store success score #pr_mirror_sneak survisland.data if entity @s[predicate=survisland:is_sneaking]

execute as @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_pair] run function survisland:modes/pr_stoupy/mirror/drive

