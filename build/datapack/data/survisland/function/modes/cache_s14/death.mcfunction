
#> survisland:modes/cache_s14/death
#
# @executed	as @a[scores={survisland.temp.death_count=1..}]
#
# @within	survisland:modes/cache_s14/tick [ as @a[scores={survisland.temp.death_count=1..}] ]
#

scoreboard players reset @s survisland.temp.death_count
tag @s add survisland.dead
gamemode spectator @s

