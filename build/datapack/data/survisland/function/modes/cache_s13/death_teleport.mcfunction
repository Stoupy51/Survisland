
#> survisland:modes/cache_s13/death_teleport
#
# @executed	as @e[type=player,tag=survisland.dead] & at @s
#
# @within	survisland:modes/cache_s13/tick [ as @e[type=player,tag=survisland.dead] & at @s ]
#

tp @s @r[distance=1..]
tag @s remove survisland.dead
tag @s remove survisland.alive

