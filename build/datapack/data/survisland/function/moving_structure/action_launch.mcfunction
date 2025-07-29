
#> survisland:moving_structure/action_launch
#
# @executed	at @s
#
# @within	survisland:moving_structure/launch_timer
#

# Set offset to every block_display with an interpolation time
execute store result score #state survisland.data run data get entity @s data.state
data modify storage survisland:temp merge set value {interpolation_duration:100,start_interpolation:0,transformation:{translation:[0.0f,0.0f,0.0f]}}
data modify storage survisland:temp merge.interpolation_duration set from entity @s data.duration
execute if score #state survisland.data matches 0 run data modify storage survisland:temp merge.transformation.translation[0] set from entity @s data.offset_x
execute if score #state survisland.data matches 0 run data modify storage survisland:temp merge.transformation.translation[1] set from entity @s data.offset_y
execute if score #state survisland.data matches 0 run data modify storage survisland:temp merge.transformation.translation[2] set from entity @s data.offset_z
scoreboard players operation #predicate survisland.id = @s survisland.id
execute as @e[type=block_display,predicate=survisland:has_same_id] run data modify entity @s {} merge from storage survisland:temp merge

# Invert the state
execute if score #state survisland.data matches 0 run data modify entity @s data.state set value 1b
execute if score #state survisland.data matches 1 run data modify entity @s data.state set value 0b

# Tag the players to move them
data modify storage survisland:temp input set value {id:0}
execute store result storage survisland:temp input.id int 1 run scoreboard players get @s survisland.id
function survisland:moving_structure/tag_players with storage survisland:temp input

# Set cooldown
execute store result score @s survisland.cooldown run data get entity @s data.duration

