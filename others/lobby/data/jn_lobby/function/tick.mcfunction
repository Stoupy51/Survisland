
# Managing Timers (tick_2, tick_second, tick_second_5)
scoreboard players add #second jn_lobby.data 1
scoreboard players add #second_5 jn_lobby.data 1
scoreboard players add #tick_2 jn_lobby.data 1
execute if score #tick_2 jn_lobby.data matches 2.. run function jn_lobby:tick_2
execute if score #second jn_lobby.data matches 20.. run function jn_lobby:tick_second
execute if score #second_5 jn_lobby.data matches 100.. run function jn_lobby:tick_second_5

# Run tick function for each player
execute as @a at @s run function jn_lobby:player/tick

