
#> survisland:modes/cache_s14/death_teleport
#
# @executed	as @e[type=player,tag=survisland.dead] & at @s
#
# @within	survisland:modes/cache_s14/tick [ as @e[type=player,tag=survisland.dead] & at @s ]
#

tp @s @r[distance=1..]
tag @s remove survisland.dead
tag @s remove survisland.alive

