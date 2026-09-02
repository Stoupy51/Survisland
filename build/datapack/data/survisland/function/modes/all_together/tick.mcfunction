
#> survisland:modes/all_together/tick
#
# @within	survisland:modes/all_together/start 1t replace [ scheduled ]
#			survisland:modes/all_together/tick 1t replace [ scheduled ]
#

# One scan of the world per tick, and the loop dies with the last group since any start brings it back
scoreboard players set #all_together_alive survisland.data 0
execute as @e[type=mannequin,tag=survisland.all_together.body] at @s run function survisland:modes/all_together/body/tick
execute if score #all_together_alive survisland.data matches 1.. run schedule function survisland:modes/all_together/tick 1t replace

