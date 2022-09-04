
##Fonction executée lors du lancement de la partie

##Explication du MDJ :
##Dans une map de laser game, les joueurs possèdent une arme capable de tirer instantanément.
##Enfin bref, tout comme au LaserGame dans la vraie vie.
##Il n'y a pas de respawn, vous voyez les pseudos de votre équipe, une fois touché, vous devenez de couleur foncée
##aux yeux des autres pendant 5 secondes et vous ne pouvez pas tirer, donc à vous de vous déplacer.
##Il y a aussi une "Base" sur la map dans un endroit bien exposé qui se recharge toutes les 30 secondes
##et qui permet d'obtenir un de ces effets au hasard :
##Bouclier (-20% de vie du bouclier par coup dessus),
##Mitrailette (vous tirez 5 fois par secondes),
##Darkness (à la team ennemie pendant 5 secondes),
##Changement de couleur (seulement visuelement donc pour brain l'ennemi: 30 secondes),
##Effet glowing sur une team (pendant 5 secondes)

clear @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ]
effect clear @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ]
gamemode adventure @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ]

## mPeluang VS mTuarua
## mAkijan VS mHainy
tag @a[team=mPeluang] add mPeluang
tag @a[team=mTuarua] add mTuarua
tag @a[team=mHainy] add mHainy
tag @a[team=mAkijan] add mAkijan

team add survisland.laser_game.blue
team add survisland.laser_game.red
team modify survisland.laser_game.blue color blue
team modify survisland.laser_game.blue seeFriendlyInvisibles true
team modify survisland.laser_game.blue nametagVisibility never
team modify survisland.laser_game.red color red
team modify survisland.laser_game.red seeFriendlyInvisibles true
team modify survisland.laser_game.red nametagVisibility never

effect give @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ] saturation 99999 255 true
effect give @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ] regeneration 5 255 true
effect give @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ] weakness 99999 255 true

##Traitement des joueurs
execute as @a[sort=random,team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ] run function survisland:modes/laser_game/teleport_players

gamerule fallDamage false

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lancement de la partie de Laser Game, tuez le plus d'ennemis possible !"}]

data modify storage iris:input TargetEntities set value true
data modify storage iris:input MaxRecursionDepth set value 50
scoreboard objectives add survisland.temp.kills dummy
scoreboard objectives add survisland.temp.shield dummy
scoreboard objectives add survisland.temp.cooldown dummy
scoreboard objectives add survisland.temp.dead_cooldown dummy
scoreboard objectives add survisland.temp.sidebar dummy {"text":"Points","color":"yellow"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #laser_game_seconds survisland.data 0
scoreboard players set #laser_game_ticks survisland.data 0
scoreboard players set #blue_points survisland.data 0
scoreboard players set #red_points survisland.data 0
scoreboard players set #remaining_time survisland.data 720
scoreboard players set #process_end survisland.data 0
scoreboard players set #base_reload survisland.data 30

team add survisland.temp.sidebar.3
team add survisland.temp.sidebar.2
team add survisland.temp.sidebar.1
team modify survisland.temp.sidebar.3 suffix [{"text":"emps restant : "},{"text":"5","color":"yellow"},{"text":"m"},{"text":"0","color":"yellow"},{"text":"s"}]
team modify survisland.temp.sidebar.2 suffix [{"text":"quipe Bleue : ","color":"blue"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.1 suffix [{"text":"uipe Rouge : ","color":"red"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.2 color blue
team modify survisland.temp.sidebar.1 color red
team join survisland.temp.sidebar.3 T
team join survisland.temp.sidebar.2 É
team join survisland.temp.sidebar.1 Éq
scoreboard players set T survisland.temp.sidebar 3
scoreboard players set É survisland.temp.sidebar 2
scoreboard players set Éq survisland.temp.sidebar 1

schedule function survisland:modes/laser_game/tick 1t replace
schedule function survisland:modes/laser_game/second 1s replace
