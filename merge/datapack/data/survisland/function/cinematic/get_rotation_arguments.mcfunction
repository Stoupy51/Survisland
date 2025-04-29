
# Get the target rotation as float type
$data modify storage survisland:temp temp set value [$(yaw), $(pitch)]
data modify storage survisland:temp target_rotation set value [0.0f, 0.0f]
execute store result storage survisland:temp target_rotation[0] float 0.001 run data get storage survisland:temp temp[0] 1000
execute store result storage survisland:temp target_rotation[1] float 0.001 run data get storage survisland:temp temp[1] 1000

## Handle wrap-around for yaw rotation when difference is greater than 180 degrees
# Store current and target yaw
execute store result score #current_yaw survisland.data run data get storage survisland:temp current_rotation[0] 1000
execute store result score #target_yaw survisland.data run data get storage survisland:temp target_rotation[0] 1000

# Calculate the difference
scoreboard players operation #yaw_diff survisland.data = #target_yaw survisland.data
scoreboard players operation #yaw_diff survisland.data -= #current_yaw survisland.data

# If difference > 180 degrees (180000), subtract 360 degrees (360000)
execute if score #yaw_diff survisland.data matches 180000.. run scoreboard players remove #yaw_diff survisland.data 360000

# If difference < -180 degrees (-180000), add 360 degrees (360000)
execute if score #yaw_diff survisland.data matches ..-180000 run scoreboard players add #yaw_diff survisland.data 360000

# Apply the corrected yaw back to target_rotation
scoreboard players operation #target_yaw survisland.data = #current_yaw survisland.data
scoreboard players operation #target_yaw survisland.data += #yaw_diff survisland.data
execute store result storage survisland:temp target_rotation[0] float 0.001 run scoreboard players get #target_yaw survisland.data

