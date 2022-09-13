
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #red_points survisland.data > #blue_points survisland.data run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin du mini-jeu avec une victoire de l'équipe rouge : "},{"selector":"@a[tag=survisland.laser_game.red,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #red_points survisland.data = #blue_points survisland.data run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin du mini-jeu ! Désolé mais il y a égalité !"}]
execute if score #process_end survisland.data matches 1 if score #red_points survisland.data < #blue_points survisland.data run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin du mini-jeu avec une victoire de l'équipe bleue : "},{"selector":"@a[tag=survisland.laser_game.blue,sort=random]"}]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ]
execute if score #process_end survisland.data matches 1 run effect clear @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ]
execute if score #process_end survisland.data matches 1 run clear @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ]

execute if score #process_end survisland.data matches 1 run fill -1269 67 -2764 -1219 68 -2814 air
execute if score #process_end survisland.data matches 1 run fill -1269 66 -2764 -1219 66 -2814 air
execute if score #process_end survisland.data matches 6 run fill -1269 65 -2764 -1219 65 -2814 air
execute if score #process_end survisland.data matches 11 run fill -1269 64 -2764 -1219 64 -2814 air
execute if score #process_end survisland.data matches 16 run fill -1269 63 -2764 -1219 63 -2814 air
execute if score #process_end survisland.data matches 21 run fill -1269 62 -2764 -1219 62 -2814 air
execute if score #process_end survisland.data matches 26 run fill -1269 61 -2764 -1219 61 -2814 air
execute if score #process_end survisland.data matches 31 run fill -1269 60 -2764 -1219 60 -2814 air
execute if score #process_end survisland.data matches 36 run fill -1269 59 -2764 -1219 59 -2814 air
execute if score #process_end survisland.data matches 41 run fill -1269 58 -2764 -1219 58 -2814 air
execute if score #process_end survisland.data matches 46 run fill -1269 57 -2764 -1219 57 -2814 air
execute if score #process_end survisland.data matches 51 run fill -1269 56 -2764 -1219 56 -2814 air
execute if score #process_end survisland.data matches 56 run fill -1269 55 -2764 -1219 55 -2814 air
execute if score #process_end survisland.data matches 61 run fill -1269 54 -2764 -1219 54 -2814 air
execute if score #process_end survisland.data matches 66 run fill -1269 53 -2764 -1219 53 -2814 air
execute if score #process_end survisland.data matches 71 run fill -1269 52 -2764 -1219 52 -2814 air
execute if score #process_end survisland.data matches 76 run fill -1269 51 -2764 -1219 51 -2814 air

execute if score #process_end survisland.data matches 100 run function survisland:modes/laser_game/stop
