
# Increase the timestamp & reset the second loop
scoreboard players add seconds jn_lobby.timestamp 1
scoreboard players set #second jn_lobby.data 0

# Run tick_second function for each player
execute as @a at @s run function jn_lobby:player/tick_second

