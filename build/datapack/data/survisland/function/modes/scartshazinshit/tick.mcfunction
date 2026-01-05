
#> survisland:modes/scartshazinshit/tick
#
# @within	survisland:modes/scartshazinshit/start 1t replace [ scheduled ]
#			survisland:modes/scartshazinshit/tick 1t replace [ scheduled ]
#

##Fonction executée tous les ticks lorsque le mode de jeu est activé
schedule function survisland:modes/scartshazinshit/tick 1t replace

scoreboard players add #scartshazinshit_ticks survisland.data 1

execute if score #detect_end survisland.data matches 0 as @a[gamemode=!spectator,gamemode=!creative] unless score @s survisland.temp.sidebar matches 100 run function survisland:modes/scartshazinshit/update_sidebar

execute if score #detect_end survisland.data matches 0 if block 0 0 0 bedrock run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 1 run function survisland:modes/scartshazinshit/process_end

