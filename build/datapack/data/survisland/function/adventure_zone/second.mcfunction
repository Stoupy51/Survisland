
#> survisland:adventure_zone/second
#
# @within	survisland:second
#			survisland:v2.4.4/second
#
# @executed			default context
# 
# @description		Function executed every second to manage the adventure zone :
# 				- Change game mode to adventure when a player enter the zone
# 				- Change game mode to survival when a player leave the zone
#

# Enter the adventure zone
execute at @e[type=marker,tag=survisland.adventure_zone] as @a[gamemode=!spectator,tag=!survisland.in_adv_zone,distance=..1000] run function survisland:adventure_zone/enter
execute at @e[type=marker,tag=survisland.medium_adventure_zone] as @a[gamemode=!spectator,tag=!survisland.in_adv_zone,distance=..250] run function survisland:adventure_zone/enter
execute at @e[type=marker,tag=survisland.small_adventure_zone] as @a[gamemode=!spectator,tag=!survisland.in_adv_zone,distance=..5] run function survisland:adventure_zone/enter

# Leave the adventure zone
execute as @a[tag=survisland.in_adv_zone] at @s unless entity @e[type=marker,tag=survisland.adventure_zone,distance=..1000] unless entity @e[type=marker,tag=survisland.medium_adventure_zone,distance=..250] unless entity @e[type=marker,tag=survisland.small_adventure_zone,distance=..5] run function survisland:adventure_zone/leave

