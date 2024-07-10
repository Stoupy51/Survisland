
##Fonction executée lors du lancement de la partie

#Ouvertures + spawn boutons
fill -1194 55 -2822 -1194 53 -2740 air replace diamond_block
fill -1211 59 -2829 -1211 56 -2733 oak_fence replace air
fill -1231 60 -2829 -1231 57 -2733 oak_fence replace air
fill -1251 61 -2829 -1251 58 -2733 oak_fence replace air
fill -1268 66 -2817 -1268 64 -2734 oak_fence replace air

setblock -1205 60 -2815 stone_button[face=wall,facing=north]
setblock -1205 60 -2799 stone_button[face=wall,facing=north]
setblock -1205 60 -2782 stone_button[face=wall,facing=north]
setblock -1205 60 -2766 stone_button[face=wall,facing=north]
setblock -1205 60 -2749 stone_button[face=wall,facing=north]
setblock -1205 60 -2733 stone_button[face=wall,facing=north]

setblock -1226 62 -2829 stone_button[face=wall,facing=south]
setblock -1226 62 -2813 stone_button[face=wall,facing=south]
setblock -1226 62 -2796 stone_button[face=wall,facing=south]
setblock -1226 62 -2780 stone_button[face=wall,facing=south]
setblock -1226 62 -2763 stone_button[face=wall,facing=south]
setblock -1226 62 -2747 stone_button[face=wall,facing=south]

setblock -1241 62 -2829 stone_button[face=floor,facing=north]
setblock -1241 62 -2813 stone_button[face=floor,facing=north]
setblock -1241 62 -2796 stone_button[face=floor,facing=north]
setblock -1241 62 -2780 stone_button[face=floor,facing=north]
setblock -1241 62 -2763 stone_button[face=floor,facing=north]
setblock -1241 62 -2747 stone_button[face=floor,facing=north]

setblock -1248 61 -2815 stone_button[face=wall,facing=north]
setblock -1248 61 -2799 stone_button[face=wall,facing=north]
setblock -1248 61 -2782 stone_button[face=wall,facing=north]
setblock -1248 61 -2766 stone_button[face=wall,facing=north]
setblock -1248 61 -2749 stone_button[face=wall,facing=north]
setblock -1248 61 -2733 stone_button[face=wall,facing=north]

setblock -1256 68 -2828 stone_button[face=wall,facing=south]
setblock -1256 68 -2812 stone_button[face=wall,facing=south]
setblock -1256 68 -2795 stone_button[face=wall,facing=south]
setblock -1256 68 -2779 stone_button[face=wall,facing=south]
setblock -1256 68 -2762 stone_button[face=wall,facing=south]
setblock -1256 68 -2746 stone_button[face=wall,facing=south]

setblock -1264 66 -2815 stone_button[face=floor,facing=south]
setblock -1264 66 -2799 stone_button[face=floor,facing=south]
setblock -1264 66 -2782 stone_button[face=floor,facing=south]
setblock -1264 66 -2766 stone_button[face=floor,facing=south]
setblock -1264 66 -2749 stone_button[face=floor,facing=south]
setblock -1264 66 -2733 stone_button[face=floor,facing=south]

setblock -1267 59 -2829 stone_button[face=wall,facing=north]
setblock -1267 59 -2813 stone_button[face=wall,facing=north]
setblock -1267 59 -2796 stone_button[face=wall,facing=north]
setblock -1267 59 -2780 stone_button[face=wall,facing=north]
setblock -1267 59 -2763 stone_button[face=wall,facing=north]
setblock -1267 59 -2747 stone_button[face=wall,facing=north]


tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lancement de la partie de Confiance Aveugle, communiquez bien !"}]

scoreboard objectives add survisland.temp.sidebar dummy {"text":"Boutons validés","color":"gray"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #conf_av_seconds survisland.data 0
scoreboard players set #conf_av_ticks survisland.data 0
scoreboard players set #mKembali_buttons survisland.data 0
scoreboard players set #mTuarua_buttons survisland.data 0
scoreboard players set #mPeluang_buttons survisland.data 0
scoreboard players set #process_end survisland.data 0
scoreboard players set #detect_end survisland.data 0

team add survisland.temp.sidebar.3
team add survisland.temp.sidebar.2
team add survisland.temp.sidebar.1
team modify survisland.temp.sidebar.3 suffix [{"text":"embali : ","color":"yellow"},{"text":"0","color":"green"},{"text":"/","color":"gray"},{"text":"14","color":"green"}]
team modify survisland.temp.sidebar.2 suffix [{"text":"uarua : ","color":"light_purple"},{"text":"0","color":"green"},{"text":"/","color":"gray"},{"text":"14","color":"green"}]
team modify survisland.temp.sidebar.1 suffix [{"text":"eluang : ","color":"aqua"},{"text":"0","color":"green"},{"text":"/","color":"gray"},{"text":"14","color":"green"}]
team modify survisland.temp.sidebar.3 color yellow
team modify survisland.temp.sidebar.2 color light_purple
team modify survisland.temp.sidebar.1 color aqua
team join survisland.temp.sidebar.3 K
team join survisland.temp.sidebar.2 T
team join survisland.temp.sidebar.1 P
scoreboard players set K survisland.temp.sidebar 3
scoreboard players set T survisland.temp.sidebar 2
scoreboard players set P survisland.temp.sidebar 1

schedule function survisland:modes/confiance_aveugle/tick 1t replace

