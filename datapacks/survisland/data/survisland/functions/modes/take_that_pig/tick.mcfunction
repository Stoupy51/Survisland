
##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/take_that_pig/tick 1t replace
scoreboard players add #take_that_pig_ticks survisland.data 1





execute if score #remaining_time survisland.data matches ..0 run function survisland:modes/take_that_pig/process_end

