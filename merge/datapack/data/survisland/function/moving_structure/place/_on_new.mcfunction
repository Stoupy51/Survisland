
# Copy tags
data modify entity @s Tags set from storage survisland:temp moving_structure.Tags
tag @s add survisland.moving_structure

# Get offset between origin and destination
execute store result score #x survisland.data run data get entity @s Pos[0]
execute store result score #y survisland.data run data get entity @s Pos[1]
execute store result score #z survisland.data run data get entity @s Pos[2]
execute store result score #dest_x survisland.data run data get storage survisland:temp moving_structure.destination[0]
execute store result score #dest_y survisland.data run data get storage survisland:temp moving_structure.destination[1]
execute store result score #dest_z survisland.data run data get storage survisland:temp moving_structure.destination[2]
scoreboard players operation #dest_x survisland.data -= #x survisland.data
scoreboard players operation #dest_y survisland.data -= #y survisland.data
scoreboard players operation #dest_z survisland.data -= #z survisland.data

# Copy offset to marker data
execute store result entity @s data.offset_x float 1 run scoreboard players get #dest_x survisland.data
execute store result entity @s data.offset_y float 1 run scoreboard players get #dest_y survisland.data
execute store result entity @s data.offset_z float 1 run scoreboard players get #dest_z survisland.data

# Copy duration and is_auto
data modify entity @s data.duration set from storage survisland:temp moving_structure.duration
data modify entity @s data.is_auto set from storage survisland:temp moving_structure.is_auto

# Copy ID & set cooldown
scoreboard players operation @s survisland.id = #next_id survisland.id
scoreboard players set @s survisland.cooldown 0

# Set state
data modify entity @s data.state set value 0b

