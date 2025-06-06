
#> survisland:modes/layers/tick
#
# @within	survisland:modes/layers/start 1t replace
#			survisland:modes/layers/tick 1t replace
#

##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/layers/tick 1t replace
scoreboard players add #layers_ticks survisland.data 1

##Traitement des joueurs
execute if score #layers_ticks survisland.data matches 40 as @a[sort=random,team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ] run function survisland:modes/layers/teleport_players
execute if score #layers_ticks survisland.data matches 40 as @a at @s run playsound entity.wither.spawn ambient @s

execute as @e[type=player,scores={survisland.temp.death_count=1..}] run function survisland:modes/layers/death

execute unless score #mHainy_restants survisland.data matches 0 store result score #mHainy_restants survisland.data if entity @a[team=mHainy,gamemode=!spectator]
execute unless score #mAkijan_restants survisland.data matches 0 store result score #mAkijan_restants survisland.data if entity @a[team=mAkijan,gamemode=!spectator]
function survisland:modes/layers/update_sidebar

execute if score #mHainy_restants survisland.data matches 0 run function survisland:modes/layers/process_end
execute unless score #mHainy_restants survisland.data matches 0 if score #mAkijan_restants survisland.data matches 0 run function survisland:modes/layers/process_end

