
#> survisland:modes/cache_cache/death
#
# @executed	as @a[scores={survisland.temp.death_count=1..}]
#
# @within	survisland:modes/cache_cache/tick [ as @a[scores={survisland.temp.death_count=1..}] ]
#

scoreboard players reset @s survisland.temp.death_count
tag @s remove survisland.alive
tag @s add survisland.dead
gamemode spectator @s

