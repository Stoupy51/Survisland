
#> survisland:cushion/place
#
# @executed	as the player & at current position
#
# @within	survisland:utils/right_click
#

# Remember the player rotation and the used cushion item (keeps the dye color)
data modify storage survisland:temp Rotation set from entity @s Rotation
data modify storage survisland:temp Item set from entity @s SelectedItem

# Round the yaw to the nearest 22.5° step (16 possible rotations, computed in half-degrees so a step is the #45 constant)
execute store result score #yaw survisland.data run data get storage survisland:temp Rotation[0] 2
scoreboard players add #yaw survisland.data 22
scoreboard players operation #yaw survisland.data /= #45 survisland.data
scoreboard players operation #yaw survisland.data *= #45 survisland.data
execute store result storage survisland:temp Rotation[0] float 0.5 run scoreboard players get #yaw survisland.data

# Raycast to place the cushion on top of the aimed block
function #bs.view:at_aimed_block {run:"function survisland:cushion/place_aimed",with:{}}

