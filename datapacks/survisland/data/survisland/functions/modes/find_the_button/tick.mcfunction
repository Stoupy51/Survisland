
##Fonction executée tous les ticks lorsque le mode de jeu est activé
schedule function survisland:modes/find_the_button/tick 1t replace

scoreboard players add #find_the_button_ticks survisland.data 1

execute if score #detect_end survisland.data matches 0 if block -1265 117 -2828 redstone_lamp[lit=true] run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 0 if block -1265 117 -2798 redstone_lamp[lit=true] run scoreboard players set #detect_end survisland.data 2
execute if score #detect_end survisland.data matches 0 if block -1265 117 -2768 redstone_lamp[lit=true] run scoreboard players set #detect_end survisland.data 3
execute if score #detect_end survisland.data matches 1.. run function survisland:modes/find_the_button/process_end

