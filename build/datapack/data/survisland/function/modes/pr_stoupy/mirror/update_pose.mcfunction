
#> survisland:modes/pr_stoupy/mirror/update_pose
#
# @executed	as @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_pair]
#
# @within	survisland:modes/pr_stoupy/mirror/drive
#

scoreboard players operation @s survisland.pr_mirror.sneak = #pr_mirror_sneak survisland.data
execute if score #pr_mirror_sneak survisland.data matches 0 run data modify entity @s pose set value "standing"
execute if score #pr_mirror_sneak survisland.data matches 1 run data modify entity @s pose set value "crouching"

