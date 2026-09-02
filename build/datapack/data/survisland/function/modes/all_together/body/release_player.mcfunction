
#> survisland:modes/all_together/body/release_player
#
# @executed	as @a[tag=survisland.all_together]
#
# @within	survisland:modes/all_together/body/stop [ as @a[tag=survisland.all_together] ]
#			survisland:modes/all_together/stop [ as @a[tag=survisland.all_together] ]
#

# Give this player its own body back
gamemode adventure @s
effect clear @s minecraft:invisibility
effect clear @s minecraft:resistance
attribute @s minecraft:scale base reset
attribute @s minecraft:gravity base reset
attribute @s minecraft:fall_damage_multiplier base reset
attribute @s minecraft:camera_distance base reset
attribute @s minecraft:entity_interaction_range base reset
attribute @s minecraft:block_interaction_range base reset

function survisland:modes/all_together/body/clear_player

