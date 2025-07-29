
#> survisland:modes/laser_game/process_end
#
# @within	survisland:modes/laser_game/tick
#

scoreboard players add #process_end survisland.data 1

execute if score #red_points survisland.data > #blue_points survisland.data run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin du mini-jeu avec une victoire de l'équipe rouge : "},{"selector":"@a[tag=survisland.laser_game.red,sort=random]"}]
execute if score #red_points survisland.data = #blue_points survisland.data run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin du mini-jeu ! Désolé mais il y a égalité !"}]
execute if score #red_points survisland.data < #blue_points survisland.data run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin du mini-jeu avec une victoire de l'équipe bleue : "},{"selector":"@a[tag=survisland.laser_game.blue,sort=random]"}]

team join mKuning @a[team=survisland.laser_game.blue]
team join mMayra @a[team=survisland.laser_game.red]

clear @a leather_chestplate
clear @a warped_fungus_on_a_stick
schedule clear survisland:modes/laser_game/tick
schedule clear survisland:modes/laser_game/second
kill @e[tag=survisland.laser_game.base]

#scoreboard objectives setdisplay sidebar survisland.temp.individual_points

