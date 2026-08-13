
#> survisland:modes/all_together/body/setup_player
#
# @executed	as @a[tag=survisland.all_together,distance=..50]
#
# @within	survisland:modes/all_together/body/setup_sensors [ as @a[tag=survisland.all_together,distance=..50] ]
#

# Turn this player into an invisible sensor (scale is clamped to 0.0625 by vanilla, 0 is impossible)
gamemode adventure @s
effect give @s minecraft:invisibility infinite 255 true
effect give @s minecraft:resistance infinite 255 true
attribute @s minecraft:scale base set 0.0625
attribute @s minecraft:gravity base set 0
attribute @s minecraft:fall_damage_multiplier base set 0

