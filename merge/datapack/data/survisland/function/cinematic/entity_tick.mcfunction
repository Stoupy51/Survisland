
# Make sure the player is spectating the entity
scoreboard players operation #predicate survisland.id = @s survisland.id
tag @p[predicate=survisland:has_same_id] add survisland.temp
spectate @s @p[tag=survisland.temp]

# Only pass 1/Interpolation of the time
scoreboard players add @s survisland.data 1
execute store result score #cinematic_interpolation survisland.data run data get entity @s item.components."minecraft:custom_data".interpolation
execute if score @s survisland.data < #cinematic_interpolation survisland.data run return run tag @a[tag=survisland.temp] remove survisland.temp
execute if score @s survisland.data >= #cinematic_interpolation survisland.data run scoreboard players set @s survisland.data 0

# Teleport to the next point and remove it from the list
data modify entity @s Pos set from entity @s item.components."minecraft:custom_data".points[0]
data remove entity @s item.components."minecraft:custom_data".points[0]

# Rotate to the next rotation and remove it from the list
data modify entity @s Rotation set from entity @s item.components."minecraft:custom_data".rotations[0]
data remove entity @s item.components."minecraft:custom_data".rotations[0]

# Happy villager particles if enabled
execute store result score #particle_effect survisland.data run data get entity @s item.components."minecraft:custom_data".particle
execute if score #particle_effect survisland.data matches 1 at @s run particle glow ~ ~ ~ 0.2 0.2 0.2 0 2
execute if score #particle_effect survisland.data matches 2 at @s run particle happy_villager ~ ~ ~ 0.2 0.2 0.2 0 2

# If the list is empty, finish the cinematic
execute unless data entity @s item.components."minecraft:custom_data".points[0] run function survisland:cinematic/finish

# Remove the tag
tag @a[tag=survisland.temp] remove survisland.temp

