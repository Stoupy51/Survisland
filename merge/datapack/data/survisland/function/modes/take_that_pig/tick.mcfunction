
##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/take_that_pig/tick 1t replace
scoreboard players add #take_that_pig_ticks survisland.data 1

#Pêche
execute if score #detect_end survisland.data matches 0..1 at @a[tag=survisland.to_take_spec] run particle happy_villager ~ ~1 ~ .5 1 .5 .1 2 force @a
execute if score #detect_end survisland.data matches 0 as @e[tag=survisland.to_take,predicate=survisland:on_concrete] at @s run function survisland:modes/take_that_pig/taken
execute if score #detect_end survisland.data matches 0 as @a[tag=survisland.to_take_spec,predicate=survisland:on_concrete] at @s run function survisland:modes/take_that_pig/taken_player

execute if score #detect_end survisland.data matches 3 run function survisland:modes/take_that_pig/process_end

