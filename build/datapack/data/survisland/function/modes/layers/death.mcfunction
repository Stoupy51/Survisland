
#> survisland:modes/layers/death
#
# @executed	as @e[type=player,scores={survisland.temp.death_count=1..}]
#
# @within	survisland:modes/layers/tick [ as @e[type=player,scores={survisland.temp.death_count=1..}] ]
#			survisland:modes/mob_escape/tick [ as @a[scores={survisland.temp.death_count=1..}] ]
#

scoreboard players reset @s survisland.temp.death_count
gamemode spectator @s
tp @s -1220 110 -2787

