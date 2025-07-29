
#> survisland:modes/laser_game/start
#
# @within	???
#

## Fonction executée lors du lancement de la partie

## Explication du MDJ :
## Dans une map de laser game, les joueurs possèdent une arme capable de tirer instantanément.
## Enfin bref, tout comme au LaserGame dans la vraie vie.
## Il n'y a pas de respawn, vous voyez les pseudos de votre équipe, une fois touché, vous devenez de couleur foncée
## aux yeux des autres pendant 5 secondes et vous ne pouvez pas tirer, donc à vous de vous déplacer.
## Il y a aussi une "Base" sur la map dans un endroit bien exposé qui se recharge toutes les 30 secondes
## et qui permet d'obtenir un de ces effets au hasard :
## Bouclier (-20% de vie du bouclier par coup dessus),
## Mitrailette (vous tirez 5 fois par secondes),
## Darkness (à la team ennemie pendant 5 secondes),
## Changement de couleur (seulement visuelement donc pour brain l'ennemi: 30 secondes),
## Effet glowing sur une team (pendant 5 secondes)

team add survisland.laser_game.blue
team add survisland.laser_game.red
team modify survisland.laser_game.blue color blue
team modify survisland.laser_game.blue seeFriendlyInvisibles true
team modify survisland.laser_game.blue nametagVisibility never
team modify survisland.laser_game.red color red
team modify survisland.laser_game.red seeFriendlyInvisibles true
team modify survisland.laser_game.red nametagVisibility never

effect give @a regeneration 5 255 true
time set 18000

## Traitement des joueurs
team join survisland.laser_game.blue @a[team=mKuning]
team join survisland.laser_game.red @a[team=mMayra]
tag @a[team=survisland.laser_game.blue] add survisland.laser_game.blue
tag @a[team=survisland.laser_game.red] add survisland.laser_game.red

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lancement de la partie de Laser Game, tuez le plus d'ennemis possible !"}]

scoreboard objectives add survisland.temp.individual_points dummy {"text":" Points Individuels ","color":"yellow"}
scoreboard objectives add survisland.temp.shield dummy
scoreboard objectives add survisland.temp.cooldown dummy
scoreboard objectives add survisland.temp.dead_cooldown dummy
scoreboard objectives add survisland.temp.sidebar dummy {"text":"Points","color":"yellow"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #laser_game_seconds survisland.data 0
scoreboard players set #laser_game_ticks survisland.data 0
scoreboard players set #blue_points survisland.data 0
scoreboard players set #red_points survisland.data 0
scoreboard players set #remaining_time survisland.data 600
scoreboard players set #process_end survisland.data 0
scoreboard players set #base_reload survisland.data 47

team add survisland.temp.sidebar.3
team add survisland.temp.sidebar.2
team add survisland.temp.sidebar.1
team modify survisland.temp.sidebar.3 suffix [{"text":"Temps restant : "},{"text":"10","color":"yellow"},{"text":"m"},{"text":"00","color":"yellow"},{"text":"s"}]
team modify survisland.temp.sidebar.2 suffix [{"text":"Équipe Bleue : ","color":"blue"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.1 suffix [{"text":"Équipe Rouge : ","color":"red"},{"text":"0","color":"yellow"}]
team modify survisland.temp.sidebar.2 color blue
team modify survisland.temp.sidebar.1 color red
team join survisland.temp.sidebar.3 §3
team join survisland.temp.sidebar.2 §2
team join survisland.temp.sidebar.1 §1
scoreboard players set §3 survisland.temp.sidebar 3
scoreboard players set §2 survisland.temp.sidebar 2
scoreboard players set §1 survisland.temp.sidebar 1

schedule function survisland:modes/laser_game/tick 1t
schedule function survisland:modes/laser_game/second 1s

