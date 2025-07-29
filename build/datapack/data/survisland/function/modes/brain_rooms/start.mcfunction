
#> survisland:modes/brain_rooms/start
#
# @within	???
#

##Fonction executée lors du lancement de la partie

gamemode adventure @a[gamemode=survival]

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.lancement_de_lpreuve_bonne_chance"}]

scoreboard objectives add survisland.temp.sidebar dummy {"translate": "survisland.progressions","color":"white"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #brain_rooms_seconds survisland.data 0
scoreboard players set #brain_rooms_ticks survisland.data 0
scoreboard players set #process_end survisland.data 0
scoreboard players set #detect_end survisland.data 0

team add survisland.temp.sidebar.3
team add survisland.temp.sidebar.2
team add survisland.temp.sidebar.1
team modify survisland.temp.sidebar.3 suffix [{"translate": "survisland.quipe_bekou","color":"red"},{"text":"0","color":"aqua"},{"text":"%","color":"gray"}]
team modify survisland.temp.sidebar.2 suffix [{"translate": "survisland.quipe_galia","color":"yellow"},{"text":"0","color":"aqua"},{"text":"%","color":"gray"}]
team modify survisland.temp.sidebar.1 suffix [{"translate": "survisland.quipe_ijo","color":"dark_purple"},{"text":"0","color":"aqua"},{"text":"%","color":"gray"}]
team modify survisland.temp.sidebar.3 color dark_aqua
team modify survisland.temp.sidebar.2 color dark_aqua
team modify survisland.temp.sidebar.1 color green
team join survisland.temp.sidebar.3 §0
team join survisland.temp.sidebar.2 §1
team join survisland.temp.sidebar.1 §2
scoreboard players set §0 survisland.temp.sidebar 2
scoreboard players set §1 survisland.temp.sidebar 1
scoreboard players set §2 survisland.temp.sidebar 0
scoreboard players set #mBekou_percentage survisland.data 0
scoreboard players set #mGalia_percentage survisland.data 0
scoreboard players set #mIjo_percentage survisland.data 0

schedule function survisland:modes/brain_rooms/tick 1t replace

