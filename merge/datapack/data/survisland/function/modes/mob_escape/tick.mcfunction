
##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/mob_escape/tick 1t replace
scoreboard players add #mob_escape_ticks survisland.data 1

execute as @a[scores={survisland.temp.death_count=1..}] run function survisland:modes/layers/death
execute as @e[type=player,scores={survisland.temp.death_count=1..}] run function survisland:modes/layers/death_tp



execute unless score #joueurs_restants survisland.data matches 0 store result score #joueurs_restants survisland.data if entity @a[tag=survisland.alive]

execute if score #joueurs_restants survisland.data matches ..1 run function survisland:modes/mob_escape/process_end

