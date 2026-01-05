
#> survisland:modes/cache_s12/tick
#
# @within	survisland:modes/cache_s12/start 1t replace [ scheduled ]
#			survisland:modes/cache_s12/tick 1t replace [ scheduled ]
#

##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/cache_s12/tick 1t replace
scoreboard players add #cache_s12_ticks survisland.data 1

# Detection de mort
execute as @a[scores={survisland.temp.death_count=1..}] run function survisland:modes/cache_s12/death
execute as @e[type=player,tag=survisland.dead] run function survisland:modes/cache_s12/death_teleport

# Heart beat
execute as @a[tag=survisland.alive] at @s run function survisland:modes/cache_s12/heart_beat

# Comptage des entités restantes
execute if score #detect_end survisland.data matches 0 unless score #mKuning_restants survisland.data matches 0 store result score #mKuning_restants survisland.data if entity @a[team=mKuning,tag=survisland.alive]
execute if score #detect_end survisland.data matches 0 unless score #mMayra_restants survisland.data matches 0 store result score #mMayra_restants survisland.data if entity @a[team=mMayra,tag=survisland.alive]
execute if score #detect_end survisland.data matches 0 unless score #specs_restants survisland.data matches 0 store result score #specs_restants survisland.data if entity @a[team=!mMayra,team=!mKuning,tag=survisland.alive]

## Detection de fin
execute if score #detect_end survisland.data matches 0 unless entity @a[tag=survisland.alive] run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 0 run scoreboard players set #detect_end survisland.data 2
execute if score #detect_end survisland.data matches 0 run function survisland:modes/cache_s12/update_sidebar_alives
execute if score #detect_end survisland.data matches 1.. run function survisland:modes/cache_s12/process_end

