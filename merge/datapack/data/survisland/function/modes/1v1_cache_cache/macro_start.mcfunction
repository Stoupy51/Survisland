
##Fonction executée lors du lancement de la partie

tag @a remove survisland.alive
tag @a[gamemode=!spectator,gamemode=!creative,tag=!survisland.seeker] add survisland.alive

scoreboard objectives add survisland.temp.death_count deathCount
scoreboard objectives add survisland.temp.sidebar dummy {"text":"Cache-Cache","color":"gold"}
scoreboard objectives add survisland.temp.heart_beat dummy
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #1v1_cache_cache_seconds survisland.data 0
scoreboard players set #1v1_cache_cache_ticks survisland.data 0
scoreboard players set #remaining_time survisland.data 1200
scoreboard players set #glowing survisland.data -540
$scoreboard players set #$(team1_id)_restants survisland.data 1
$scoreboard players set #$(team2_id)_restants survisland.data 1
scoreboard players set #specs_restants survisland.data 1
$scoreboard players set #$(team1_id)_points survisland.data 0
$scoreboard players set #$(team2_id)_points survisland.data 0
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
team modify survisland.temp.sidebar.8 suffix [{"text":"Temps restant : "},{"text":"20","color":"gray"},{"text":"m"},{"text":"0","color":"gray"},{"text":"s"}]
team modify survisland.temp.sidebar.7 suffix [{"text":"Specs restants : ","color":"gray"},{"text":"0","color":"white"}]
$team modify survisland.temp.sidebar.6 suffix [{"text":"------$(team1_name)------","color":"$(team1_color)"}]
$team modify survisland.temp.sidebar.5 suffix [{"text":"Joueurs restants : ","color":"$(team1_color)"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.4 suffix [{"text":"Points : ","color":"white"},{"text":"0","color":"yellow"}]
$team modify survisland.temp.sidebar.3 suffix [{"text":"------$(team2_name)------","color":"$(team2_color)"}]
$team modify survisland.temp.sidebar.2 suffix [{"text":"Joueurs restants : ","color":"$(team2_color)"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.1 suffix [{"text":"Points : ","color":"white"},{"text":"0","color":"yellow"}]
team join survisland.temp.sidebar.8 §8
team join survisland.temp.sidebar.7 §7
team join survisland.temp.sidebar.6 §6
team join survisland.temp.sidebar.5 §5
team join survisland.temp.sidebar.4 §4
team join survisland.temp.sidebar.3 §3
team join survisland.temp.sidebar.2 §2
team join survisland.temp.sidebar.1 §1
scoreboard players set §8 survisland.temp.sidebar 8
scoreboard players set §7 survisland.temp.sidebar 7
scoreboard players set §6 survisland.temp.sidebar 6
scoreboard players set §5 survisland.temp.sidebar 5
scoreboard players set §4 survisland.temp.sidebar 4
scoreboard players set §3 survisland.temp.sidebar 3
scoreboard players set §2 survisland.temp.sidebar 2
scoreboard players set §1 survisland.temp.sidebar 1

schedule function survisland:modes/1v1_cache_cache/tick 1t replace
schedule function survisland:modes/1v1_cache_cache/second 20t replace

