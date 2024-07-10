
#> survisland:modes/cache_cache/death
#
# @within	survisland:modes/cache_cache/tick
#

scoreboard players reset @s survisland.temp.deathCount
tag @s remove survisland.alive
tag @s add survisland.dead
gamemode spectator @s

