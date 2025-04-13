
# Get the current timestamp unit
data modify storage jn_lobby:main temp set from storage suso.str:io out.time[0]

# Convert the timestamp unit to a number
scoreboard players set #value jn_lobby.data 0
execute if score #value jn_lobby.data matches 0 if data storage jn_lobby:main {temp:"1"} run scoreboard players set #value jn_lobby.data 1
execute if score #value jn_lobby.data matches 0 if data storage jn_lobby:main {temp:"2"} run scoreboard players set #value jn_lobby.data 2
execute if score #value jn_lobby.data matches 0 if data storage jn_lobby:main {temp:"3"} run scoreboard players set #value jn_lobby.data 3
execute if score #value jn_lobby.data matches 0 if data storage jn_lobby:main {temp:"4"} run scoreboard players set #value jn_lobby.data 4
execute if score #value jn_lobby.data matches 0 if data storage jn_lobby:main {temp:"5"} run scoreboard players set #value jn_lobby.data 5
execute if score #value jn_lobby.data matches 0 if data storage jn_lobby:main {temp:"6"} run scoreboard players set #value jn_lobby.data 6
execute if score #value jn_lobby.data matches 0 if data storage jn_lobby:main {temp:"7"} run scoreboard players set #value jn_lobby.data 7
execute if score #value jn_lobby.data matches 0 if data storage jn_lobby:main {temp:"8"} run scoreboard players set #value jn_lobby.data 8
execute if score #value jn_lobby.data matches 0 if data storage jn_lobby:main {temp:"9"} run scoreboard players set #value jn_lobby.data 9

# Apply the multiplier
scoreboard players operation #value jn_lobby.data *= #multiplier jn_lobby.data
scoreboard players operation #temp_seconds jn_lobby.timestamp += #value jn_lobby.data
scoreboard players operation #multiplier jn_lobby.data /= #10 jn_lobby.data

# Repeat until the multiplier is 0
data remove storage suso.str:io out.time[0]
execute if score #multiplier jn_lobby.data matches 1.. run function jn_lobby:utils/update_timestamp_loop

