
#> survisland:modes/1v1v1v1_cache_cache/death_teleport
#
# @executed	as @e[type=player,tag=survisland.dead] & at @s
#
# @within	survisland:modes/1v1v1v1_cache_cache/macro_tick [ as @e[type=player,tag=survisland.dead] & at @s ]
#

tp @s @r[distance=1..]
tag @s remove survisland.dead
tag @s remove survisland.alive

