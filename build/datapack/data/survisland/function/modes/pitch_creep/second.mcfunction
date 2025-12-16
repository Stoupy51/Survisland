
#> survisland:modes/pitch_creep/second
#
# @within	survisland:modes/pitch_creep/second 20t replace [ scheduled ]
#			survisland:modes/pitch_creep/start 20t replace [ scheduled ]
#

##Fonction executée toutes les secondes lorsque le mode de jeu est activé

schedule function survisland:modes/pitch_creep/second 20t replace
scoreboard players add #pitch_creep_seconds survisland.data 1

execute if score #pitch_creep_seconds survisland.data matches 3 run summon creeper 0 0 0 {Tags:["survisland.creeper","survisland.new"],AbsorptionAmount:2048.0f}
execute if score #pitch_creep_seconds survisland.data matches 3 as @e[type=creeper,tag=survisland.new] run function survisland:modes/pitch_creep/creeper
scoreboard players operation #pitch_creep_seconds survisland.data %= #3 survisland.data

