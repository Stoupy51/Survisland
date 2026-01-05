
#> survisland:modes/1v1v1v1_cache_cache/macro_tick
#
# @within	survisland:modes/1v1v1v1_cache_cache/tick with storage survisland:main cache_cache_config
#
# @args		team1_id (string)
#			team2_id (string)
#			team3_id (unknown)
#			team4_id (unknown)
#

##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/1v1v1v1_cache_cache/tick 1t replace
scoreboard players add #1v1v1v1_cache_cache_ticks survisland.data 1

# Detection de mort
execute as @a[scores={survisland.temp.death_count=1..}] run function survisland:modes/1v1v1v1_cache_cache/death
execute as @e[type=player,tag=survisland.dead] at @s run function survisland:modes/1v1v1v1_cache_cache/death_teleport

# Heart beat
execute as @a[tag=survisland.alive] at @s run function survisland:modes/1v1v1v1_cache_cache/heart_beat

# Comptage des joueurs restants
$execute if score #detect_end survisland.data matches 0 unless score #$(team1_id)_restants survisland.data matches 0 store result score #$(team1_id)_restants survisland.data if entity @a[team=$(team1_id),tag=survisland.alive]
$execute if score #detect_end survisland.data matches 0 unless score #$(team2_id)_restants survisland.data matches 0 store result score #$(team2_id)_restants survisland.data if entity @a[team=$(team2_id),tag=survisland.alive]
$execute if score #detect_end survisland.data matches 0 unless score #$(team3_id)_restants survisland.data matches 0 store result score #$(team3_id)_restants survisland.data if entity @a[team=$(team3_id),tag=survisland.alive]
$execute if score #detect_end survisland.data matches 0 unless score #$(team4_id)_restants survisland.data matches 0 store result score #$(team4_id)_restants survisland.data if entity @a[team=$(team4_id),tag=survisland.alive]
$execute if score #detect_end survisland.data matches 0 unless score #specs_restants survisland.data matches 0 store result score #specs_restants survisland.data if entity @a[team=!$(team4_id),team=!$(team3_id),team=!$(team2_id),team=!$(team1_id),tag=survisland.alive]

## Detection de fin
execute if score #detect_end survisland.data matches 0 unless entity @a[tag=survisland.alive] run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 0 run scoreboard players set #detect_end survisland.data 2
$execute if score #detect_end survisland.data matches 0 store result storage survisland:main cache_cache_config.team1_remaining int 1 run scoreboard players get #$(team1_id)_restants survisland.data
$execute if score #detect_end survisland.data matches 0 store result storage survisland:main cache_cache_config.team2_remaining int 1 run scoreboard players get #$(team2_id)_restants survisland.data
$execute if score #detect_end survisland.data matches 0 store result storage survisland:main cache_cache_config.team3_remaining int 1 run scoreboard players get #$(team3_id)_restants survisland.data
$execute if score #detect_end survisland.data matches 0 store result storage survisland:main cache_cache_config.team4_remaining int 1 run scoreboard players get #$(team4_id)_restants survisland.data
execute if score #detect_end survisland.data matches 0 store result storage survisland:main cache_cache_config.specs_remaining int 1 run scoreboard players get #specs_restants survisland.data
execute if score #detect_end survisland.data matches 0 run function survisland:modes/1v1v1v1_cache_cache/update_sidebar_alives with storage survisland:main cache_cache_config
execute if score #detect_end survisland.data matches 1.. run function survisland:modes/1v1v1v1_cache_cache/process_end with storage survisland:main cache_cache_config

