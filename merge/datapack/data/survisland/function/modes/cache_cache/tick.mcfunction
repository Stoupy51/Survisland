
##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/cache_cache/tick 1t replace
scoreboard players add #cache_cache_ticks survisland.data 1

#Detection de mort
execute as @a[scores={survisland.temp.death_count=1..}] run function survisland:modes/cache_cache/death
execute as @e[type=player,tag=survisland.dead] run function survisland:modes/cache_cache/death_teleport

#Heart beat
execute as @a[tag=survisland.alive] at @s run function survisland:modes/cache_cache/heart_beat

#Comptage des entités restantes
execute if score #detect_end survisland.data matches 0 unless score #mAkijan_restants survisland.data matches 0 store result score #mAkijan_restants survisland.data if entity @a[team=mAkijan,tag=survisland.alive]
execute if score #detect_end survisland.data matches 0 unless score #mHainy_restants survisland.data matches 0 store result score #mHainy_restants survisland.data if entity @a[team=mHainy,tag=survisland.alive]
execute if score #detect_end survisland.data matches 0 unless score #specs_restants survisland.data matches 0 store result score #specs_restants survisland.data if entity @a[team=!mHainy,team=!mAkijan,tag=survisland.alive]

##Detection de fin
execute if score #detect_end survisland.data matches 0 unless entity @a[tag=survisland.alive] run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 0 run scoreboard players set #detect_end survisland.data 2
execute if score #detect_end survisland.data matches 0 run function survisland:modes/cache_cache/update_sidebar
execute if score #detect_end survisland.data matches 1.. run function survisland:modes/cache_cache/process_end


