
##Fonction executée lors du lancement de la partie

tag @a remove survisland.winner

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lancement de l'épreuve de scartshit, bonne chance !"}]

scoreboard objectives add survisland.temp.sidebar dummy {"text":"Progression en %","color":"yellow"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #scartshit_seconds survisland.data 0
scoreboard players set #scartshit_ticks survisland.data 0
scoreboard players set #process_end survisland.data 0
scoreboard players set #detect_end survisland.data 0
scoreboard players set @a[gamemode=!spectator,gamemode=!creative] survisland.temp.sidebar 0

schedule function survisland:modes/scartshit/tick 1t replace

