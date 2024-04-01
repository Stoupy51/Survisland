
# Get state and cooldown
execute store result score #state survisland.data run data get entity @s data.state
scoreboard players operation #cooldown survisland.data = @s survisland.cooldown

# Copy ID in storage
data modify storage survisland:temp input set value {id:0}
execute store result storage survisland:temp input.id int 1 run scoreboard players get @s survisland.id

# Calculate progress percentage (with 2 decimals), ex: 10000*198/200 = 9900 (99,00%)
execute store result score #duration survisland.data run data get entity @s data.duration
scoreboard players set #multiplier survisland.data 10000
scoreboard players operation #multiplier survisland.data *= #cooldown survisland.data
scoreboard players operation #multiplier survisland.data /= #duration survisland.data
execute if score #cooldown survisland.data matches ..1 run scoreboard players set #multiplier survisland.data 0

# If the structure is not returning to original position: reverse the progress
execute if score #state survisland.data matches 1 run scoreboard players set #reverse survisland.data 10000
execute if score #state survisland.data matches 1 run scoreboard players operation #reverse survisland.data -= #multiplier survisland.data
execute if score #state survisland.data matches 1 run scoreboard players operation #multiplier survisland.data = #reverse survisland.data

# Calculate the current position with help of the offset
execute store result score #offset_x survisland.data run data get entity @s data.offset_x
execute store result score #offset_y survisland.data run data get entity @s data.offset_y
execute store result score #offset_z survisland.data run data get entity @s data.offset_z
scoreboard players operation #offset_x survisland.data *= #multiplier survisland.data
scoreboard players operation #offset_y survisland.data *= #multiplier survisland.data
scoreboard players operation #offset_z survisland.data *= #multiplier survisland.data

# Teleport players and make particles
execute store result storage survisland:temp input.x double 0.0001 run scoreboard players get #offset_x survisland.data
execute store result storage survisland:temp input.y double 0.0001 run scoreboard players get #offset_y survisland.data
execute store result storage survisland:temp input.z double 0.0001 run scoreboard players get #offset_z survisland.data
execute summon marker run function survisland:moving_structure/action_teleport with storage survisland:temp input

