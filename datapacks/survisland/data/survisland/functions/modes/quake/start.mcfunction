
## Fonction executée lors du lancement de la partie

effect give @a[team=mMerge] speed 400 1 true
effect give @a[team=mMerge] jump_boost 400 3 true

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lancement de la partie de Quake, tuez le plus d'ennemis possible !"}]

scoreboard objectives add survisland.temp.points dummy {"text":" Points ","color":"yellow"}
scoreboard objectives add survisland.temp.cooldown dummy
scoreboard objectives add survisland.temp.dead_cooldown dummy
scoreboard objectives setdisplay sidebar survisland.temp.points

scoreboard players set #quake_seconds survisland.data 0
scoreboard players set #quake_ticks survisland.data 0
scoreboard players set #remaining_time survisland.data 400
scoreboard players set #process_end survisland.data 0

schedule function survisland:modes/quake/tick 1t
schedule function survisland:modes/quake/second 1s

