
#> survisland:modes/quake/shoot
#
# @executed	as @a[scores={survisland.right_click=1..},sort=random] & at @s
#
# @within	survisland:modes/quake/right_click
#

tag @s add survisland.temp

scoreboard players set @s survisland.temp.cooldown -24
playsound survisland:laser_gun ambient @s

execute anchored eyes positioned ^ ^ ^ run function iris:get_target
execute as @e[tag=iris.ray] run function iris:set_coordinates
execute as @e[tag=iris.target,tag=!survisland.temp] if entity @s[team=mMerge] unless score @s survisland.temp.dead_cooldown matches ..-1 at @s run function survisland:modes/quake/shooted_player
execute as @e[tag=iris.ray] at @s run function survisland:modes/quake/shoot_particles

kill @e[type=marker,tag=iris.ray]
tag @e[type=!#iris:ignore] remove iris.target
tag @s remove survisland.temp

