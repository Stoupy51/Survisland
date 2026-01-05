
#> survisland:modes/cache_s16/tick
#
# @within	survisland:modes/cache_s16/start 1t replace [ scheduled ]
#			survisland:modes/cache_s16/tick 1t replace [ scheduled ]
#

##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/cache_s16/tick 1t replace
scoreboard players add #cache_s16_ticks survisland.data 1

# Detection de mort
execute as @a[scores={survisland.temp.death_count=1..}] run function survisland:modes/cache_s16/death
execute as @e[type=player,tag=survisland.dead] at @s run function survisland:modes/cache_s16/death_teleport

# Heart beat
execute as @a[tag=survisland.alive] at @s run function survisland:modes/cache_s16/heart_beat

# Comptage des entités restantes
execute if score #detect_end survisland.data matches 0 unless score #mLiwai_restants survisland.data matches 0 store result score #mLiwai_restants survisland.data if entity @a[team=mLiwai,tag=survisland.alive]
execute if score #detect_end survisland.data matches 0 unless score #mMoemoea_restants survisland.data matches 0 store result score #mMoemoea_restants survisland.data if entity @a[team=mMoemoea,tag=survisland.alive]
execute if score #detect_end survisland.data matches 0 unless score #specs_restants survisland.data matches 0 store result score #specs_restants survisland.data if entity @a[team=!mMoemoea,team=!mLiwai,tag=survisland.alive]

## Detection de fin
execute if score #detect_end survisland.data matches 0 unless entity @a[tag=survisland.alive] run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 0 run scoreboard players set #detect_end survisland.data 2
execute if score #detect_end survisland.data matches 0 run function survisland:modes/cache_s16/update_sidebar_alives
execute if score #detect_end survisland.data matches 1.. run function survisland:modes/cache_s16/process_end

