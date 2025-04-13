
# Enable triggers
scoreboard players enable @s jn_lobby.trigger.plugins
scoreboard players enable @s jn_lobby.trigger.spawn

# Run welcome back message
execute if score @s jn_lobby.leave matches 1.. run function jn_lobby:player/joined
scoreboard players operation @s jn_lobby.timestamp = seconds jn_lobby.timestamp

