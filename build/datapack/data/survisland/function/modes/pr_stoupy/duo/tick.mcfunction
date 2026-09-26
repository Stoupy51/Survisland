
#> survisland:modes/pr_stoupy/duo/tick
#
# @within	survisland:modes/pr_stoupy/duo/start 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/duo/tick 1t replace [ scheduled ]
#

# One scan of the world per tick, and the loop dies with the last group since any start brings it back
scoreboard players set #pr_stoupy_duo_alive survisland.data 0
execute as @e[type=mannequin,tag=survisland.pr_stoupy_duo.body] at @s run function survisland:modes/pr_stoupy/duo/body/tick
execute if score #pr_stoupy_duo_alive survisland.data matches 1.. run schedule function survisland:modes/pr_stoupy/duo/tick 1t replace

