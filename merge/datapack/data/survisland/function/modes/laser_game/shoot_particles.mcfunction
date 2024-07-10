
tp @s ~ ~ ~ facing entity @p[tag=survisland.temp] eyes
execute if score #color survisland.data matches 0 run particle dust{color:[0,0,1],scale:0.5} ~ ~ ~ 0 0 0 0 1
execute if score #color survisland.data matches 1 run particle dust{color:[1,0,0],scale:0.5} ~ ~ ~ 0 0 0 0 1
tp @s ^ ^ ^.025

execute unless entity @a[tag=survisland.temp,distance=..2] at @s run function survisland:modes/laser_game/shoot_particles
