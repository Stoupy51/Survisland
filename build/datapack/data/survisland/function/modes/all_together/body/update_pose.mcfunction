
#> survisland:modes/all_together/body/update_pose
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/tick
#

scoreboard players operation @s survisland.all_together.pose = #all_together_pose survisland.data
execute if score #all_together_pose survisland.data matches 0 run data modify entity @s pose set value "standing"
execute if score #all_together_pose survisland.data matches 1 run data modify entity @s pose set value "crouching"
execute if score #all_together_pose survisland.data matches 2 run data modify entity @s pose set value "swimming"

