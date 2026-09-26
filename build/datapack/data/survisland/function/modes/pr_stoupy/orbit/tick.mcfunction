
#> survisland:modes/pr_stoupy/orbit/tick
#
# @within	survisland:modes/pr_stoupy/orbit/tick 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/orbit/start 1t replace [ scheduled ]
#

scoreboard players set #pr_orbit_active survisland.data 0
execute as @e[type=minecraft:marker,tag=survisland.pr_orbit.hole] at @s run function survisland:modes/pr_stoupy/orbit/arena_tick
execute if score #pr_orbit_active survisland.data matches 1.. run schedule function survisland:modes/pr_stoupy/orbit/tick 1t replace

