
#> survisland:modes/minecart_lever/start
#
# @within	???
#

##Fonction executée lors du lancement de la partie

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lancement de l'épreuve ! Soyez le premier à activer tous les leviers !"}]

gamemode adventure @a[gamemode=survival]
time set 18000

scoreboard objectives add survisland.temp.sidebar dummy {"text":"Classement des lampes","color":"yellow"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #minecart_lever_ticks survisland.data 0
scoreboard players set #process_end survisland.data 0
scoreboard players set #detect_end survisland.data 0

team add survisland.temp.sidebar.1
team modify survisland.temp.sidebar.1 suffix [{"text":" à atteindre : ","color":"light_purple"}]
team modify survisland.temp.sidebar.1 color light_purple
team join survisland.temp.sidebar.1 Objectif
scoreboard players set Objectif survisland.temp.sidebar 23
scoreboard players set @a[gamemode=!creative,gamemode=!spectator] survisland.temp.sidebar 0

execute as @a at @s run playsound item.goat_horn.sound.0 ambient @s

schedule function survisland:modes/minecart_lever/tick 1t replace

