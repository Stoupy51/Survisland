
##Fonction executée toutes les secondes lorsque le mode de jeu est activé

scoreboard players add #laser_game_seconds survisland.data 1
scoreboard players remove #base_reload survisland.data 1
execute if score #base_reload survisland.data matches 0 run tellraw @a [{"text":"La base de bonus vient de se recharger !","color":"yellow"}]
execute if score #base_reload survisland.data matches 0 run setblock -1253 60 -2791 iron_trapdoor[powered=true,open=true]
execute if score #base_reload survisland.data matches 1.. run setblock -1253 60 -2791 dark_oak_trapdoor[powered=true,open=true]


#Bonus mitraillette + change color
scoreboard players remove #mitraillette survisland.data 1
scoreboard players remove #change_color survisland.data 1
execute if score #mitraillette survisland.data matches ..0 run tag @a[tag=survisland.bonus.fast] remove survisland.bonus.fast
execute if score #change_color survisland.data matches ..0 run team join survisland.laser_game.blue @a[tag=survisland.bonus.color,tag=survisland.laser_game.blue]
execute if score #change_color survisland.data matches ..0 run team join survisland.laser_game.red @a[tag=survisland.bonus.color,tag=survisland.laser_game.red]
execute if score #change_color survisland.data matches ..0 run tag @a[tag=survisland.bonus.color] remove survisland.bonus.color


scoreboard players remove #remaining_time survisland.data 1
function survisland:modes/laser_game/update_sidebar/timer

schedule function survisland:modes/laser_game/second 1s replace
