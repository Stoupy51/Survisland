
#> survisland:modes/scartshazinshit/process_end
#
# @within	survisland:modes/scartshazinshit/tick
#

scoreboard players add #process_end survisland.data 1

#Fin
execute if score #process_end survisland.data matches 1200 run function survisland:modes/scartshazinshit/stop

