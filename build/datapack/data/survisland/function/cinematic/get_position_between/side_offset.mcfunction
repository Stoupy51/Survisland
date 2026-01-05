
#> survisland:cinematic/get_position_between/side_offset
#
# @within	survisland:cinematic/get_position_between/main with storage survisland:temp forward
#
# @args		amount (unknown)
#

# Go to the half position
data modify entity @s Pos set from storage survisland:temp half_position

# Look at the target position (because looking at half position is looking at the target position)
execute positioned ~ ~ ~ facing entity @s feet positioned as @s run tp @s ~ ~ ~ ~ ~

# Rotate based on yaw direction
execute if score #yaw_diff survisland.data matches 1.. at @s run tp @s ~ ~ ~ ~-90 ~
execute if score #yaw_diff survisland.data matches ..0 at @s run tp @s ~ ~ ~ ~90 ~

# Move forward
$execute at @s run tp @s ^ ^ ^$(amount)

# Remember the position
data modify storage survisland:temp half_position set from entity @s Pos

# Kill the entity
kill @s[type=!player]

