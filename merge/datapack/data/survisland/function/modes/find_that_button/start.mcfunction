
##Fonction executée lors du lancement de la partie

gamemode adventure @a[gamemode=survival]
gamerule fall_damage false

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lancement de la partie de Find That Button ! Activez-les tous, BOUTONMONE !"}]

scoreboard objectives add survisland.temp.sidebar dummy {"text":"Boutons validés","color":"gray"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #find_that_button_seconds survisland.data 0
scoreboard players set #find_that_button_ticks survisland.data 0
scoreboard players set #mKembali_buttons survisland.data 0
scoreboard players set #mTuarua_buttons survisland.data 0
scoreboard players set #mPeluang_buttons survisland.data 0
scoreboard players set #process_end survisland.data 0
scoreboard players set #detect_end survisland.data 0

team add survisland.temp.sidebar.3
team add survisland.temp.sidebar.2
team add survisland.temp.sidebar.1
team modify survisland.temp.sidebar.3 suffix [{"text":"embali : ","color":"yellow"},{"text":"0","color":"green"},{"text":"/","color":"gray"},{"text":"20","color":"green"}]
team modify survisland.temp.sidebar.2 suffix [{"text":"uarua : ","color":"light_purple"},{"text":"0","color":"green"},{"text":"/","color":"gray"},{"text":"20","color":"green"}]
team modify survisland.temp.sidebar.1 suffix [{"text":"eluang : ","color":"aqua"},{"text":"0","color":"green"},{"text":"/","color":"gray"},{"text":"20","color":"green"}]
team modify survisland.temp.sidebar.3 color yellow
team modify survisland.temp.sidebar.2 color light_purple
team modify survisland.temp.sidebar.1 color aqua
team join survisland.temp.sidebar.3 K
team join survisland.temp.sidebar.2 T
team join survisland.temp.sidebar.1 P
scoreboard players set K survisland.temp.sidebar 3
scoreboard players set T survisland.temp.sidebar 2
scoreboard players set P survisland.temp.sidebar 1

schedule function survisland:modes/find_that_button/tick 1t replace

