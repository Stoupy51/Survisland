
#> survisland:modes/scartshazinshit/start
#
# @within	???
#

##Fonction executée lors du lancement de la partie

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.lancement_de_lpreuve_de_scartshazinshit_bonne_chance"}]

setblock 0 0 0 iron_block
scoreboard objectives add survisland.temp.sidebar dummy {"translate": "survisland.progression_en","color":"yellow"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #scartshazinshit_seconds survisland.data 0
scoreboard players set #scartshazinshit_ticks survisland.data 0
scoreboard players set #process_end survisland.data 0
scoreboard players set #detect_end survisland.data 0
scoreboard players set @a[gamemode=!spectator,gamemode=!creative] survisland.temp.sidebar 0

schedule function survisland:modes/scartshazinshit/tick 1t replace

