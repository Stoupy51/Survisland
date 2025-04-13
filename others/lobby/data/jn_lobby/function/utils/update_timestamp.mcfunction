
# Reset the timestamp to 0
scoreboard players set #temp_seconds jn_lobby.timestamp 0

# Start the loop at 1 billion (Length of the value is 10)
scoreboard players set #multiplier jn_lobby.data 1000000000
execute if data storage suso.str:io out.time[0] run function jn_lobby:utils/update_timestamp_loop

# Update the timestamp if higher than the current one
execute if score #temp_seconds jn_lobby.timestamp > seconds jn_lobby.timestamp run scoreboard players operation seconds jn_lobby.timestamp = #temp_seconds jn_lobby.timestamp

