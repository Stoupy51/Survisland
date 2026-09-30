
#> survisland:modes/pr_stoupy/duo/body/release_player
#
# @executed	as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50]
#
# @within	survisland:modes/pr_stoupy/duo/body/stop [ as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] ]
#			survisland:modes/pr_stoupy/duo/stop [ as @a[tag=survisland.pr_stoupy_duo] ]
#

# Give this player its own body back
execute if predicate survisland:riding run ride @s dismount
effect clear @s minecraft:invisibility
item replace entity @s armor.body with minecraft:air
attribute @s minecraft:scale base reset
attribute @s minecraft:gravity base reset
attribute @s minecraft:fall_damage_multiplier base reset
attribute @s minecraft:camera_distance base reset
attribute @s minecraft:entity_interaction_range base reset
attribute @s minecraft:block_interaction_range base reset
attribute @s minecraft:block_break_speed base reset

function survisland:modes/pr_stoupy/duo/body/clear_player

function survisland:modes/pr_stoupy/send_back

