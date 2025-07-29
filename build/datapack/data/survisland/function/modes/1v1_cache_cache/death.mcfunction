
#> survisland:modes/1v1_cache_cache/death
#
# @executed	as @a[scores={survisland.temp.death_count=1..}]
#
# @within	survisland:modes/1v1_cache_cache/macro_tick [ as @a[scores={survisland.temp.death_count=1..}] ]
#

scoreboard players reset @s survisland.temp.death_count
tag @s add survisland.dead
gamemode spectator @s

