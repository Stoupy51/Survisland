
scoreboard players set #color survisland.data 0
execute store success score #color survisland.data if entity @s[tag=survisland.laser_game.red]

execute if score #color survisland.data matches 0 run tellraw @a[tag=survisland.laser_game.blue,tag=!survisland.temp] [{"selector":"@s"},{"text":" a tiré sur la base de bonus !","color":"green"}]
execute if score #color survisland.data matches 0 run tellraw @a[tag=survisland.laser_game.red,tag=!survisland.temp] [{"text":"Un joueur ennemi a tiré sur la base de bonus !","color":"green"}]
execute if score #color survisland.data matches 1 run tellraw @a[tag=survisland.laser_game.red,tag=!survisland.temp] [{"selector":"@s"},{"text":" a tiré sur la base de bonus !","color":"green"}]
execute if score #color survisland.data matches 1 run tellraw @a[tag=survisland.laser_game.blue,tag=!survisland.temp] [{"text":"Un joueur ennemi a tiré sur la base de bonus !","color":"green"}]
execute as @a at @s run playsound entity.player.levelup ambient @s

summon marker 0 0 0 {Tags:["survisland.random"]}
scoreboard players set #list_length survisland.data 5
execute as @e[tag=survisland.random] run function survisland:random

execute if score #random survisland.data matches 0 run tellraw @s [{"text":"Vous avez tiré sur la base de bonus et vous obtenez un Bouclier résistant à 5 tirs [+20 points]","color":"green"}]
execute if score #random survisland.data matches 1 run tellraw @s [{"text":"Vous avez tiré sur la base de bonus et vous obtenez une Mitraillette pendant 15 secondes [+20 points]","color":"green"}]
execute if score #random survisland.data matches 2 run tellraw @s [{"text":"Vous avez tiré sur la base de bonus et vous donnez un Effet Darkness à la team ennemie [+20 points]","color":"green"}]
execute if score #random survisland.data matches 3 run tellraw @s [{"text":"Vous avez tiré sur la base de bonus et vous donnez un Effet Glowing à la team ennemie [+20 points]","color":"green"}]
execute if score #random survisland.data matches 4 run tellraw @s [{"text":"Vous avez tiré sur la base de bonus et vous obtenez un Changement de couleur visuellement pendant 30 secondes [+20 points]","color":"green"}]

execute if score #random survisland.data matches 0 run scoreboard players set @s survisland.temp.shield 5
execute if score #random survisland.data matches 1 run scoreboard players set #mitraillette survisland.data 15
execute if score #random survisland.data matches 1 run tag @s add survisland.bonus.fast
execute if score #random survisland.data matches 2 if score #color survisland.data matches 0 run effect give @a[tag=survisland.laser_game.red] darkness 5 255 true
execute if score #random survisland.data matches 2 if score #color survisland.data matches 1 run effect give @a[tag=survisland.laser_game.blue] darkness 5 255 true
execute if score #random survisland.data matches 3 if score #color survisland.data matches 0 run effect give @a[tag=survisland.laser_game.red] glowing 5 255 true
execute if score #random survisland.data matches 3 if score #color survisland.data matches 1 run effect give @a[tag=survisland.laser_game.blue] glowing 5 255 true
execute if score #random survisland.data matches 4 run scoreboard players set #change_color survisland.data 30
execute if score #random survisland.data matches 4 run team join survisland.laser_game.blue @s[tag=survisland.laser_game.red]
execute if score #random survisland.data matches 4 run team join survisland.laser_game.red @s[tag=survisland.laser_game.blue]
execute if score #random survisland.data matches 4 run tag @s add survisland.bonus.color

execute if score #color survisland.data matches 0 run scoreboard players add #blue_points survisland.data 20
execute if score #color survisland.data matches 0 run function survisland:modes/laser_game/update_sidebar/blue_points
execute if score #color survisland.data matches 1 run scoreboard players add #red_points survisland.data 20
execute if score #color survisland.data matches 1 run function survisland:modes/laser_game/update_sidebar/red_points

scoreboard players set #base_reload survisland.data 30
setblock -1253 60 -2791 dark_oak_trapdoor[powered=true,open=true]

/say Pour les bonus du LaserGame qu'il y avait :
/say - un Bouclier résistant à 5 tirs [+20 points]
/say - une Mitraillette pendant 15 secondes [+20 points]
/say - un Effet Darkness à la team ennemie [+20 points]
/say - un Effet Glowing à la team ennemie [+20 points]
/say - un Changement de couleur visuellement pendant 30 secondes [+20 points]



