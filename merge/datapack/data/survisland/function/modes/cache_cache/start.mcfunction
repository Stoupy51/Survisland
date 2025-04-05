
##Fonction executée lors du lancement de la partie

tag @a remove survisland.alive
tag @a[gamemode=!spectator,gamemode=!creative,tag=!survisland.seeker] add survisland.alive
gamemode adventure @a[tag=survisland.alive]
effect give @a[gamemode=!spectator,gamemode=!creative] blindness 900 0 true
execute as @a at @s run playsound item.goat_horn.sound.1 ambient @s
effect give @a[tag=survisland.seeker] strength 900 255 true
effect give @a[tag=survisland.seeker] resistance 900 255 true
effect give @a[tag=survisland.seeker] speed 900 0 true

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lancement de l'épreuve, restez bien cachés !"}]

scoreboard objectives add survisland.temp.death_count deathCount
scoreboard objectives add survisland.temp.sidebar dummy {"text":"Cache-Cache","color":"gold"}
scoreboard objectives add survisland.temp.heart_beat dummy
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #cache_cache_seconds survisland.data 0
scoreboard players set #cache_cache_ticks survisland.data 0
scoreboard players set #remaining_time survisland.data 900
scoreboard players set #glowing survisland.data -300
scoreboard players set #mAkijan_restants survisland.data 1
scoreboard players set #mHainy_restants survisland.data 1
scoreboard players set #specs_restants survisland.data 1
scoreboard players set #mAkijan_points survisland.data 0
scoreboard players set #mHainy_points survisland.data 0
scoreboard players set #process_end survisland.data 0
scoreboard players set #detect_end survisland.data 0

team add survisland.temp.sidebar.8
team add survisland.temp.sidebar.7
team add survisland.temp.sidebar.6
team add survisland.temp.sidebar.5
team add survisland.temp.sidebar.4
team add survisland.temp.sidebar.3
team add survisland.temp.sidebar.2
team add survisland.temp.sidebar.1
team modify survisland.temp.sidebar.8 suffix [{"text":"emps restant : "},{"text":"15","color":"yellow"},{"text":"m"},{"text":"0","color":"yellow"},{"text":"s"}]
team modify survisland.temp.sidebar.7 suffix [{"text":" restants : ","color":"gray"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.6 suffix [{"text":"ijan------","color":"dark_aqua"}]
team modify survisland.temp.sidebar.5 suffix [{"text":"eurs restants : ","color":"dark_aqua"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.4 suffix [{"text":"s : ","color":"dark_aqua"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.3 suffix [{"text":"iny-------","color":"green"}]
team modify survisland.temp.sidebar.2 suffix [{"text":"urs restants : ","color":"green"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.1 suffix [{"text":" : ","color":"green"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.8 color white
team modify survisland.temp.sidebar.7 color gray
team modify survisland.temp.sidebar.6 color dark_aqua
team modify survisland.temp.sidebar.5 color dark_aqua
team modify survisland.temp.sidebar.4 color dark_aqua
team modify survisland.temp.sidebar.3 color green
team modify survisland.temp.sidebar.2 color green
team modify survisland.temp.sidebar.1 color green
team join survisland.temp.sidebar.8 T
team join survisland.temp.sidebar.7 Specs
team join survisland.temp.sidebar.6 ------Ak
team join survisland.temp.sidebar.5 Jou
team join survisland.temp.sidebar.4 Point
team join survisland.temp.sidebar.3 ------Ha
team join survisland.temp.sidebar.2 Joue
team join survisland.temp.sidebar.1 Points
scoreboard players set T survisland.temp.sidebar 8
scoreboard players set Specs survisland.temp.sidebar 7
scoreboard players set ------Ak survisland.temp.sidebar 6
scoreboard players set Jou survisland.temp.sidebar 5
scoreboard players set Point survisland.temp.sidebar 4
scoreboard players set ------Ha survisland.temp.sidebar 3
scoreboard players set Joue survisland.temp.sidebar 2
scoreboard players set Points survisland.temp.sidebar 1

schedule function survisland:modes/cache_cache/tick 1t replace
schedule function survisland:modes/cache_cache/second 20t replace

