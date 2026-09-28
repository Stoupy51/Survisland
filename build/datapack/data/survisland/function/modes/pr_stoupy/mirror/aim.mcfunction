
#> survisland:modes/pr_stoupy/mirror/aim
#
# @executed	as @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_pair]
#
# @within	survisland:modes/pr_stoupy/mirror/drive
#

# rotate gives the head the angle written in the body, its ~ being relative to the rotation of the source
scoreboard players operation @s survisland.pr_mirror.yaw = #pr_mirror_yaw survisland.data
scoreboard players operation @s survisland.pr_mirror.pitch = #pr_mirror_pitch survisland.data
execute store result entity @s Rotation[0] float 0.01 run scoreboard players get #pr_mirror_yaw survisland.data
execute store result entity @s Rotation[1] float 0.01 run scoreboard players get #pr_mirror_pitch survisland.data
execute rotated as @s run rotate @s ~ ~

