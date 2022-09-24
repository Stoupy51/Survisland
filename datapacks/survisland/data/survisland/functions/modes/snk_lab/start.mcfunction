
##Fonction executée lors du lancement de la partie

gamemode adventure @a[gamemode=survival]
gamerule fallDamage false

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lancement de l'épreuve de SNK Lab, bonne chance !"}]

scoreboard objectives add survisland.temp.sidebar dummy {"text":"Progression","color":"yellow"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #snk_lab_seconds survisland.data 0
scoreboard players set #snk_lab_ticks survisland.data 0
scoreboard players set #mAkijan_percentage survisland.data 0
scoreboard players set #mHainy_percentage survisland.data 0
scoreboard players set #process_end survisland.data 0
scoreboard players set #detect_end survisland.data 0

team add survisland.temp.sidebar.2
team add survisland.temp.sidebar.1
team modify survisland.temp.sidebar.2 suffix [{"text":"kijan : ","color":"dark_aqua"},{"text":"0","color":"yellow"},{"text":"%","color":"gray"}]
team modify survisland.temp.sidebar.1 suffix [{"text":"ainy : ","color":"green"},{"text":"0","color":"yellow"},{"text":"%","color":"gray"}]
team modify survisland.temp.sidebar.2 color dark_aqua
team modify survisland.temp.sidebar.1 color green
team join survisland.temp.sidebar.2 A
team join survisland.temp.sidebar.1 H
scoreboard players set A survisland.temp.sidebar 2
scoreboard players set H survisland.temp.sidebar 1

schedule function survisland:modes/snk_lab/tick 1t replace

