
##Fonction executée tous les ticks lorsque le mode de jeu est activé
schedule function survisland:modes/scartshit/tick 1t replace

scoreboard players add #scartshit_ticks survisland.data 1

execute if score #detect_end survisland.data matches 0 as @a[gamemode=!spectator,gamemode=!creative] run function survisland:modes/scartshit/update_sidebar

execute if score #detect_end survisland.data matches 0 if entity @a[tag=survisland.winner] run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 1 run function survisland:modes/scartshit/process_end

