
##Fonction executée lors du lancement de la partie

tag @a[gamemode=!spectator,gamemode=!creative] add survisland.alive
gamemode adventure @a[tag=survisland.alive]
# give @a[tag=survisland.alive] wooden_shovel{survisland:{pitch_creep:1b},Unbreakable:1b,display:{Name:'{"text":"À enfoncer avec précaution","color":"yellow","italic":false}'},Enchantments:[{id:"minecraft:knockback",lvl:5s}]}
# give @a[tag=survisland.alive] bow{survisland:{pitch_creep:1b},Unbreakable:1b,display:{Name:'{"text":"M\'APPROCHE PAS !!!","color":"yellow","italic":false}'},Enchantments:[{id:"minecraft:infinity",lvl:10s},{id:"minecraft:punch",lvl:3s}]}
give @a[tag=survisland.alive] arrow
execute as @a[tag=survisland.alive] run attribute @s generic.attack_speed base set 2048.0



tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lancement de la partie de Pitch Creep, anéantissez l'équipe ennemie !"}]

scoreboard objectives add survisland.temp.deathCount deathCount
scoreboard objectives add survisland.temp.sidebar dummy {"text":"Joueurs restants","color":"yellow"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #pitch_creep_seconds survisland.data 0
scoreboard players set #pitch_creep_ticks survisland.data 0
scoreboard players set #creepers_restants survisland.data 0
scoreboard players set #mTuarua_restants survisland.data 1
scoreboard players set #mPeluang_restants survisland.data 1
scoreboard players set #process_end survisland.data 0
scoreboard players set #detect_end survisland.data 0

team add survisland.temp.sidebar.3
team add survisland.temp.sidebar.2
team add survisland.temp.sidebar.1
team modify survisland.temp.sidebar.3 suffix [{"text":"reepers : ","color":"green"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.2 suffix [{"text":"uarua : ","color":"light_purple"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.1 suffix [{"text":"eluang : ","color":"aqua"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.3 color green
team modify survisland.temp.sidebar.2 color light_purple
team modify survisland.temp.sidebar.1 color aqua
team join survisland.temp.sidebar.3 C
team join survisland.temp.sidebar.2 T
team join survisland.temp.sidebar.1 P
scoreboard players set C survisland.temp.sidebar 3
scoreboard players set T survisland.temp.sidebar 2
scoreboard players set P survisland.temp.sidebar 1

schedule function survisland:modes/pitch_creep/tick 1t replace
schedule function survisland:modes/pitch_creep/second 20t replace

