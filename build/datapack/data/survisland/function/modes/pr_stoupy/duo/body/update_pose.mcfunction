
#> survisland:modes/pr_stoupy/duo/body/update_pose
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/body/tick
#

scoreboard players operation @s survisland.pr_stoupy_duo.pose = #pr_stoupy_duo_pose survisland.data
execute if score #pr_stoupy_duo_pose survisland.data matches 0 run data modify entity @s pose set value "standing"
execute if score #pr_stoupy_duo_pose survisland.data matches 1 run data modify entity @s pose set value "crouching"
execute if score #pr_stoupy_duo_pose survisland.data matches 2 run data modify entity @s pose set value "swimming"

