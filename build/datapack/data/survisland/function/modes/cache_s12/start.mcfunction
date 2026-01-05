
#> survisland:modes/cache_s12/start
#
# @within	???
#

##Fonction executée lors du lancement de la partie

tag @a remove survisland.alive
tag @a[gamemode=!spectator,gamemode=!creative,tag=!survisland.seeker] add survisland.alive

scoreboard objectives add survisland.temp.death_count deathCount
scoreboard objectives add survisland.temp.sidebar dummy {"text":"Cache-Cache","color":"gold"}
scoreboard objectives add survisland.temp.heart_beat dummy
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #cache_s12_seconds survisland.data 0
scoreboard players set #cache_s12_ticks survisland.data 0
scoreboard players set #remaining_time survisland.data 1200
scoreboard players set #glowing survisland.data -540
scoreboard players set #mKuning_restants survisland.data 1
scoreboard players set #mMayra_restants survisland.data 1
scoreboard players set #specs_restants survisland.data 1
scoreboard players set #mKuning_points survisland.data 0
scoreboard players set #mMayra_points survisland.data 0
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
team modify survisland.temp.sidebar.8 suffix [{"text":"emps restant : "},{"text":"20","color":"gray"},{"text":"m"},{"text":"0","color":"gray"},{"text":"s"}]
team modify survisland.temp.sidebar.7 suffix [{"text":" restants : ","color":"gray"},{"text":"0","color":"white"}]
team modify survisland.temp.sidebar.6 suffix [{"text":"ning------","color":"yellow"}]
team modify survisland.temp.sidebar.5 suffix [{"text":"eurs restants : ","color":"yellow"},{"text":"0","color":"gray"}]
team modify survisland.temp.sidebar.4 suffix [{"text":"s : ","color":"yellow"},{"text":"0","color":"gray"}]
team modify survisland.temp.sidebar.3 suffix [{"text":"yra------","color":"red"}]
team modify survisland.temp.sidebar.2 suffix [{"text":"urs restants : ","color":"red"},{"text":"0","color":"gray"}]
team modify survisland.temp.sidebar.1 suffix [{"text":" : ","color":"red"},{"text":"0","color":"gray"}]
team modify survisland.temp.sidebar.8 color white
team modify survisland.temp.sidebar.7 color gray
team modify survisland.temp.sidebar.6 color yellow
team modify survisland.temp.sidebar.5 color yellow
team modify survisland.temp.sidebar.4 color yellow
team modify survisland.temp.sidebar.3 color red
team modify survisland.temp.sidebar.2 color red
team modify survisland.temp.sidebar.1 color red
team join survisland.temp.sidebar.8 T
team join survisland.temp.sidebar.7 Specs
team join survisland.temp.sidebar.6 ------Ku
team join survisland.temp.sidebar.5 Jou
team join survisland.temp.sidebar.4 Point
team join survisland.temp.sidebar.3 ------Ma
team join survisland.temp.sidebar.2 Joue
team join survisland.temp.sidebar.1 Points
scoreboard players set T survisland.temp.sidebar 8
scoreboard players set Specs survisland.temp.sidebar 7
scoreboard players set ------Ku survisland.temp.sidebar 6
scoreboard players set Jou survisland.temp.sidebar 5
scoreboard players set Point survisland.temp.sidebar 4
scoreboard players set ------Ma survisland.temp.sidebar 3
scoreboard players set Joue survisland.temp.sidebar 2
scoreboard players set Points survisland.temp.sidebar 1

schedule function survisland:modes/cache_s12/tick 1t replace
schedule function survisland:modes/cache_s12/second 20t replace

