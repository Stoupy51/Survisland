
#> survisland:cinematic/setup_entity
#
# @within	survisland:cinematic/launch
#

## As we are updating every X ticks, teleport duration is X and step is multiplied by X
# Increment the number of cinematic entities and add convention tags
scoreboard players add #cinematic_entities survisland.data 1
tag @s add survisland.cinematic
tag @s add smithed.entity
tag @s add smithed.strict
tag @s add global.ignore.kill
tag @s add global.ignore

# Set the interpolation to the given value + 1, and set start loop timer (@s survisland.data)
scoreboard players operation @s survisland.data = #cinematic_interpolation survisland.data
scoreboard players add @s survisland.data 1
execute if score @s survisland.data matches 2.. run execute store result entity @s teleport_duration int 1 run scoreboard players get @s survisland.data
scoreboard players remove @s survisland.data 2

## Stream Bezier
# Prepare storages for Stream Bezier
data modify storage survisland:temp initial_points set value {points:[],step:5}
data modify storage survisland:temp rotation_points set value []

# Get the current position (for the first point)
data modify entity @s Rotation set from storage survisland:temp current_rotation
data modify storage survisland:temp initial_points.points append from storage survisland:temp current_position
data modify storage survisland:temp rotation_points append from storage survisland:temp current_rotation
data modify storage survisland:temp rotation_points append from storage survisland:temp current_rotation

# Get a position between (with a little offset)
function survisland:cinematic/get_position_between/main

# Get the target position
data modify storage survisland:temp initial_points.points append from storage survisland:temp target_position
data modify storage survisland:temp initial_points.points append from storage survisland:temp target_position
data modify storage survisland:temp rotation_points append from storage survisland:temp target_rotation
data modify storage survisland:temp rotation_points append from storage survisland:temp target_rotation

# Compute the step depending on the time (X / total time, We keep 6 decimals)
scoreboard players set #cinematic_step survisland.data 1000000
execute if score #cinematic_interpolation survisland.data matches 1.. run scoreboard players operation #cinematic_step survisland.data *= #cinematic_interpolation survisland.data
scoreboard players operation #cinematic_step survisland.data /= #cinematic_time survisland.data
execute store result storage survisland:temp initial_points.step double 0.000001 run scoreboard players get #cinematic_step survisland.data
data modify storage survisland:temp item set value {id:"minecraft:stone",count:1,components:{"minecraft:item_model":"minecraft:air"}}
data modify storage survisland:temp item.components."minecraft:custom_data".interpolation set from storage survisland:temp with.interpolation

## Get all the points (not the first one), add the target position and remember them
data modify storage bs:in spline.sample_bezier set from storage survisland:temp initial_points
function #bs.spline:sample_bezier
data modify storage bs:out spline.sample_bezier append from storage survisland:temp target_position
execute if score #cinematic_interpolation survisland.data matches ..2 run data modify storage bs:out spline.sample_bezier append from storage survisland:temp target_position
execute if score #cinematic_interpolation survisland.data matches ..1 run data modify storage bs:out spline.sample_bezier append from storage survisland:temp target_position
data modify storage survisland:temp item.components."minecraft:custom_data".points set from storage bs:out spline.sample_bezier

## Get all the rotations (not the first one), add the target rotation and remember them
data modify storage survisland:temp initial_points.points set from storage survisland:temp rotation_points
data modify storage bs:in spline.sample_bspline set from storage survisland:temp initial_points
function #bs.spline:sample_bspline
data modify storage bs:out spline.sample_bspline append from storage survisland:temp target_rotation
execute if score #cinematic_interpolation survisland.data matches ..2 run data modify storage bs:out spline.sample_bspline append from storage survisland:temp target_rotation
execute if score #cinematic_interpolation survisland.data matches ..1 run data modify storage bs:out spline.sample_bspline append from storage survisland:temp target_rotation
data modify storage survisland:temp item.components."minecraft:custom_data".rotations set from storage bs:out spline.sample_bspline

## Remember everything, player's id and gamemode, make the player spectator, then make them mount @s (item_display)
data modify storage survisland:temp item.components."minecraft:custom_data".particle set from storage survisland:temp with.particle
data modify entity @s item set from storage survisland:temp item
scoreboard players operation @s survisland.id = #player_id survisland.id
execute if entity @p[tag=survisland.temp,gamemode=survival] run tag @s add survisland.was_survival
execute if entity @p[tag=survisland.temp,gamemode=adventure] run tag @s add survisland.was_adventure
execute if entity @p[tag=survisland.temp,gamemode=creative] run tag @s add survisland.was_creative
gamemode spectator @p[tag=survisland.temp]
spectate @s @p[tag=survisland.temp]

