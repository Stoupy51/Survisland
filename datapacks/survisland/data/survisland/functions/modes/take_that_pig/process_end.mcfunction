
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 run function survisland:modes/take_that_pig/find_winner

#Fin
execute if score #process_end survisland.data matches 600 run function survisland:modes/take_that_pig/stop

