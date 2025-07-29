
#> survisland:adventure_zone/enter
#
# @within	survisland:adventure_zone/second
#			survisland:adventure_zone/second [ at @e[type=marker,tag=survisland.adventure_zone] & as @a[gamemode=!spectator,tag=!survisland.in_adv_zone,distance=..1000] ]
#			survisland:adventure_zone/second [ at @e[type=marker,tag=survisland.medium_adventure_zone] & as @a[gamemode=!spectator,tag=!survisland.in_adv_zone,distance=..250] ]
#			survisland:adventure_zone/second [ at @e[type=marker,tag=survisland.small_adventure_zone] & as @a[gamemode=!spectator,tag=!survisland.in_adv_zone,distance=..5] ]
#
# @executed			as the player who entered the zone
# 
# @description		Switches the player to adventure mode and tags them
#

# Survival -> Adventure
gamemode adventure @s[gamemode=survival]

# Tag player
tag @s add survisland.in_adv_zone

