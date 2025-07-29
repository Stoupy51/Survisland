
#> survisland:modes/cache_s12/death_teleport
#
# @executed	as @e[type=player,tag=survisland.dead]
#
# @within	survisland:modes/cache_s12/tick [ as @e[type=player,tag=survisland.dead] ]
#

tp @s 120 80 120
tag @s remove survisland.dead
tag @s remove survisland.alive

