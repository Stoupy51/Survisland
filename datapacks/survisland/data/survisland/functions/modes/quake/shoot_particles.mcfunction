
tp @s ~ ~ ~ facing entity @p[tag=survisland.temp] eyes
particle dust 0.569 0 0.761 0.5 ~ ~ ~ 0 0 0 0 1
tp @s ^ ^ ^.025

execute unless entity @a[tag=survisland.temp,distance=..2] at @s run function survisland:modes/quake/shoot_particles

