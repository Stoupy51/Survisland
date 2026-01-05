
#> survisland:modes/brain_rooms/tick
#
# @within	survisland:modes/brain_rooms/start 1t replace [ scheduled ]
#			survisland:modes/brain_rooms/tick 1t replace [ scheduled ]
#

##Fonction executée tous les ticks lorsque le mode de jeu est activé
schedule function survisland:modes/brain_rooms/tick 1t replace

scoreboard players add #brain_rooms_ticks survisland.data 1

execute if score #mBekou_percentage survisland.data matches 100 run scoreboard players set #detect_end survisland.data 1
execute if score #mGalia_percentage survisland.data matches 100 run scoreboard players set #detect_end survisland.data 2
execute if score #mIjo_percentage survisland.data matches 100 run scoreboard players set #detect_end survisland.data 3
execute if score #detect_end survisland.data matches 0 run function survisland:modes/brain_rooms/update_sidebar

# Détection de fin de partie
execute if score #detect_end survisland.data matches 1.. run function survisland:modes/brain_rooms/process_end

