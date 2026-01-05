
#> survisland:modes/cache_s14/start
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

scoreboard players set #cache_s14_seconds survisland.data 0
scoreboard players set #cache_s14_ticks survisland.data 0
scoreboard players set #remaining_time survisland.data 1200
scoreboard players set #glowing survisland.data -540
scoreboard players set #mPonogoro_restants survisland.data 1
scoreboard players set #mKecak_restants survisland.data 1
scoreboard players set #mSinaoh_restants survisland.data 1
scoreboard players set #specs_restants survisland.data 1
scoreboard players set #mPonogoro_points survisland.data 0
scoreboard players set #mKecak_points survisland.data 0
scoreboard players set #mSinaoh_points survisland.data 0
scoreboard players set #process_end survisland.data 0
scoreboard players set #detect_end survisland.data 0

team add survisland.temp.sidebar.11
team add survisland.temp.sidebar.10
team add survisland.temp.sidebar.9
team add survisland.temp.sidebar.8
team add survisland.temp.sidebar.7
team add survisland.temp.sidebar.6
team add survisland.temp.sidebar.5
team add survisland.temp.sidebar.4
team add survisland.temp.sidebar.3
team add survisland.temp.sidebar.2
team add survisland.temp.sidebar.1
team modify survisland.temp.sidebar.11 suffix [{"text":"Temps restant : "},{"text":"20","color":"gray"},{"text":"m"},{"text":"0","color":"gray"},{"text":"s"}]
team modify survisland.temp.sidebar.10 suffix [{"text":"Specs restants : ","color":"gray"},{"text":"0","color":"white"}]
team modify survisland.temp.sidebar.9 suffix [{"text":"-----Ponogoro-----","color":"light_purple"}]
team modify survisland.temp.sidebar.8 suffix [{"text":"Joueurs restants : ","color":"light_purple"},{"text":"0","color":"gray"}]
team modify survisland.temp.sidebar.7 suffix [{"text":"Points : ","color":"light_purple"},{"text":"0","color":"gray"}]
team modify survisland.temp.sidebar.6 suffix [{"text":"------Kecak-------","color":"gold"}]
team modify survisland.temp.sidebar.5 suffix [{"text":"Joueurs restants : ","color":"gold"},{"text":"0","color":"gray"}]
team modify survisland.temp.sidebar.4 suffix [{"text":"Points : ","color":"gold"},{"text":"0","color":"gray"}]
team modify survisland.temp.sidebar.3 suffix [{"text":"------Sinaoh------","color":"green"}]
team modify survisland.temp.sidebar.2 suffix [{"text":"Joueurs restants : ","color":"green"},{"text":"0","color":"gray"}]
team modify survisland.temp.sidebar.1 suffix [{"text":"Points : ","color":"green"},{"text":"0","color":"gray"}]
team join survisland.temp.sidebar.11 §b
team join survisland.temp.sidebar.10 §a
team join survisland.temp.sidebar.9 §9
team join survisland.temp.sidebar.8 §8
team join survisland.temp.sidebar.7 §7
team join survisland.temp.sidebar.6 §6
team join survisland.temp.sidebar.5 §5
team join survisland.temp.sidebar.4 §4
team join survisland.temp.sidebar.3 §3
team join survisland.temp.sidebar.2 §2
team join survisland.temp.sidebar.1 §1
scoreboard players set §b survisland.temp.sidebar 11
scoreboard players set §a survisland.temp.sidebar 10
scoreboard players set §9 survisland.temp.sidebar 9
scoreboard players set §8 survisland.temp.sidebar 8
scoreboard players set §7 survisland.temp.sidebar 7
scoreboard players set §6 survisland.temp.sidebar 6
scoreboard players set §5 survisland.temp.sidebar 5
scoreboard players set §4 survisland.temp.sidebar 4
scoreboard players set §3 survisland.temp.sidebar 3
scoreboard players set §2 survisland.temp.sidebar 2
scoreboard players set §1 survisland.temp.sidebar 1

schedule function survisland:modes/cache_s14/tick 1t replace
schedule function survisland:modes/cache_s14/second 20t replace

