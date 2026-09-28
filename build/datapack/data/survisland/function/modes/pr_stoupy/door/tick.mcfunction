
#> survisland:modes/pr_stoupy/door/tick
#
# @within	survisland:modes/pr_stoupy/duo/start 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/mirror/start 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/breakout/start 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/orbit/start 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/door/tick 10t replace [ scheduled ]
#

scoreboard players set #pr_stoupy_closed survisland.data 0
execute as @e[type=minecraft:marker,tag=survisland.pr_stoupy.door] at @s run function survisland:modes/pr_stoupy/door/update with entity @s data
execute if score #pr_stoupy_closed survisland.data matches 1.. run schedule function survisland:modes/pr_stoupy/door/tick 10t replace

