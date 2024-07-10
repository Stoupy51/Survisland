
#> survisland:modes/minecart_lever/tick
#
# @within	survisland:modes/minecart_lever/start 1t replace
#			survisland:modes/minecart_lever/tick 1t replace
#

##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/minecart_lever/tick 1t replace
scoreboard players add #minecart_lever_ticks survisland.data 1

execute if score #detect_end survisland.data matches 1 run function survisland:modes/minecart_lever/process_end

