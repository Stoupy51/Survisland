
#> survisland:modes/cache_s13/tick
#
# @within	survisland:modes/cache_s13/start 1t replace
#			survisland:modes/cache_s13/tick 1t replace
#

##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/cache_s13/tick 1t replace
scoreboard players add #cache_s13_ticks survisland.data 1

# Detection de mort
execute as @a[scores={survisland.temp.deathCount=1..}] run function survisland:modes/cache_s13/death
execute as @e[type=player,tag=survisland.dead] at @s run function survisland:modes/cache_s13/death_teleport

# Heart beat
execute as @a[tag=survisland.alive] at @s run function survisland:modes/cache_s13/heart_beat

# Comptage des entités restantes
execute if score #detect_end survisland.data matches 0 unless score #mSambor_restants survisland.data matches 0 store result score #mSambor_restants survisland.data if entity @a[team=mSambor,tag=survisland.alive]
execute if score #detect_end survisland.data matches 0 unless score #mKanawa_restants survisland.data matches 0 store result score #mKanawa_restants survisland.data if entity @a[team=mKanawa,tag=survisland.alive]
execute if score #detect_end survisland.data matches 0 unless score #specs_restants survisland.data matches 0 store result score #specs_restants survisland.data if entity @a[team=!mKanawa,team=!mSambor,tag=survisland.alive]

## Detection de fin
execute if score #detect_end survisland.data matches 0 unless entity @a[tag=survisland.alive] run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 0 run scoreboard players set #detect_end survisland.data 2
execute if score #detect_end survisland.data matches 0 run function survisland:modes/cache_s13/update_sidebar_alives
execute if score #detect_end survisland.data matches 1.. run function survisland:modes/cache_s13/process_end


