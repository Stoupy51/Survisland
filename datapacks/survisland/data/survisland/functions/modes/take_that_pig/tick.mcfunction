
##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/take_that_pig/tick 1t replace
scoreboard players add #take_that_pig_ticks survisland.data 1


execute at @a[tag=survisland.to_take_spec] run particle happy_villager ~ ~1 ~ .5 1 .5 .1 2 force @a

execute as @e[y=50,dy=3,tag=survisland.to_take,predicate=survisland:on_concrete] run function survisland:modes/take_that_pig/taken
execute as @a[y=50,dy=3,tag=survisland.to_take_spec,predicate=survisland:on_concrete] run function survisland:modes/take_that_pig/taken_player


execute if score #remaining_time survisland.data matches ..0 run function survisland:modes/take_that_pig/process_end

