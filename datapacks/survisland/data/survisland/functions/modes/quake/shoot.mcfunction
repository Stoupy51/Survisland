
tag @s add survisland.temp

scoreboard players set @s survisland.temp.cooldown -24
playsound survisland:laser_gun ambient @s

function iris:setup/load
execute anchored eyes positioned ^ ^ ^ run function iris:get_target
execute as @e[tag=iris.ray] run function iris:set_coordinates
execute as @e[tag=iris.target,team=mMerge,tag=!survisland.temp] unless score @s survisland.temp.dead_cooldown matches ..-1 at @s run function survisland:modes/quake/shooted_player
execute as @e[tag=iris.ray] at @s run function survisland:modes/quake/shoot_particles

kill @e[type=marker,tag=iris.ray]
tag @e[type=!#iris:ignore] remove iris.target
tag @s remove survisland.temp

