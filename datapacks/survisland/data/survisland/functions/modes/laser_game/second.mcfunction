
## Fonction executée toutes les secondes lorsque le mode de jeu est activé

scoreboard players add #laser_game_seconds survisland.data 1

execute if score #laser_game_seconds survisland.data matches 10 run kill @e[tag=survisland.laser_game.base]
execute if score #laser_game_seconds survisland.data matches 10 run summon item_frame 136 73 116 {Tags:["survisland.laser_game.base"],Facing:2b,Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b,Glowing:1b}


# Base reload
scoreboard players remove #base_reload survisland.data 1
execute if score #base_reload survisland.data matches 0 run tellraw @a [{"text":"La base de bonus vient de se recharger !","color":"yellow"}]
execute if score #base_reload survisland.data matches 0 run setblock 136 73 116 iron_trapdoor[powered=true,open=true]
execute if score #base_reload survisland.data matches 0 as @e[tag=survisland.laser_game.base] run data modify entity @s Item set value {id:"minecraft:experience_bottle",Count:1b}
execute if score #base_reload survisland.data matches 1.. run setblock 136 73 116 dark_oak_trapdoor[powered=true,open=true]


# Bonus mitraillette + change color
scoreboard players remove #mitraillette survisland.data 1
scoreboard players remove #change_color survisland.data 1
execute if score #mitraillette survisland.data matches ..0 run tag @a[tag=survisland.bonus.fast] remove survisland.bonus.fast
execute if score #change_color survisland.data matches ..0 run team join survisland.laser_game.blue @a[tag=survisland.bonus.color,tag=survisland.laser_game.blue]
execute if score #change_color survisland.data matches ..0 run team join survisland.laser_game.red @a[tag=survisland.bonus.color,tag=survisland.laser_game.red]
execute if score #change_color survisland.data matches ..0 run tag @a[tag=survisland.bonus.color] remove survisland.bonus.color

# Temps restant
scoreboard players remove #remaining_time survisland.data 1
function survisland:modes/laser_game/update_sidebar/timer/

execute if score #remaining_time survisland.data matches 1.. run schedule function survisland:modes/laser_game/second 1s

