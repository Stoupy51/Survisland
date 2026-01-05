
#> survisland:modes/quake/shoot_particles
#
# @executed	as @e[tag=iris.ray] & at @s
#
# @within	survisland:modes/quake/shoot [ as @e[tag=iris.ray] & at @s ]
#			survisland:modes/quake/shoot_particles [ at @s ]
#

tp @s ~ ~ ~ facing entity @p[tag=survisland.temp] eyes
particle dust{color:[145,0,194],scale:0.5} ~ ~ ~ 0 0 0 0 1 force @a[distance=0..]
tp @s ^ ^ ^.025

execute unless entity @a[tag=survisland.temp,distance=..2] at @s run function survisland:modes/quake/shoot_particles

