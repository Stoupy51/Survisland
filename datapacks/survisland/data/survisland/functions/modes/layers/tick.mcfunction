
##Fonction executée tous les ticks lorsque le mode de jeu est activé

scoreboard players add #layers_ticks survisland.data 1

##Traitement des joueurs
execute if score #layers_ticks survisland.data matches 40 as @a[sort=random,team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ] run function survisland:modes/layers/teleport_players
execute if score #layers_ticks survisland.data matches 40 as @a at @s run playsound entity.wither.spawn ambient @s

execute as @e[type=player,scores={survisland.temp.deathCount=1..}] run function survisland:modes/layers/death

scoreboard players set #mHainy_restants survisland.data 0
scoreboard players set #mAkijan_restants survisland.data 0
execute unless score #mHainy_restants survisland.data matches 0 store result score #mHainy_restants survisland.data if entity @a[team=mHainy,gamemode=survival]
execute unless score #mAkijan_restants survisland.data matches 0 store result score #mAkijan_restants survisland.data if entity @a[team=mAkijan,gamemode=survival]
function survisland:modes/layers/update_sidebar

schedule function survisland:modes/layers/tick 1t replace

execute if score #mHainy_restants survisland.data matches 0 run function survisland:modes/layers/process_end
execute unless score #mHainy_restants survisland.data matches 0 if score #mAkijan_restants survisland.data matches 0 run function survisland:modes/layers/process_end

