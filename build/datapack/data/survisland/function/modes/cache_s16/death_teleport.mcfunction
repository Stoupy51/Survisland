
#> survisland:modes/cache_s16/death_teleport
#
# @executed	as @e[type=player,tag=survisland.dead] & at @s
#
# @within	survisland:modes/cache_s16/tick [ as @e[type=player,tag=survisland.dead] & at @s ]
#

tp @s @r[distance=1..]
tag @s remove survisland.dead
tag @s remove survisland.alive

