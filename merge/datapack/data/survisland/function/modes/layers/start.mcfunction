
##Fonction executée lors du lancement de la partie

effect clear @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ]
execute at @a run particle campfire_cosy_smoke ~ ~60 ~ 2 5 2 0 1000 force
effect give @a levitation 2 30 true

## mAkijan VS mHainy
team modify mHainy nametagVisibility never
team modify mAkijan nametagVisibility never
team modify mHainy friendlyFire false
team modify mAkijan friendlyFire false

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lancement de la partie de Layers, exterminez l'équipe ennemie !"}]

scoreboard objectives add survisland.temp.death_count deathCount
scoreboard objectives add survisland.temp.sidebar dummy {"text":"Joueurs restants","color":"yellow"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #layers_seconds survisland.data 0
scoreboard players set #layers_ticks survisland.data 0
scoreboard players set #mHainy_restants survisland.data 1
scoreboard players set #mAkijan_restants survisland.data 1
scoreboard players set #process_end survisland.data 0

team add survisland.temp.sidebar.2
team add survisland.temp.sidebar.1
team modify survisland.temp.sidebar.2 suffix [{"text":"kijan : ","color":"dark_aqua"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.1 suffix [{"text":"ainy : ","color":"green"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.2 color dark_aqua
team modify survisland.temp.sidebar.1 color green
team join survisland.temp.sidebar.2 A
team join survisland.temp.sidebar.1 H
scoreboard players set A survisland.temp.sidebar 2
scoreboard players set H survisland.temp.sidebar 1

schedule function survisland:modes/layers/tick 1t replace

