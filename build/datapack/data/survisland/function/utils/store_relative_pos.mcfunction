
#> survisland:utils/store_relative_pos
#
# @within	survisland:utils/relative
#

# Store position and kill temporary entity
execute if score #state survisland.data matches 0 run data modify storage survisland:main relative_pos set from entity @s Pos
execute if score #state survisland.data matches 1 store result score #dest_x survisland.data run data get entity @s Pos[0]
execute if score #state survisland.data matches 1 store result score #dest_y survisland.data run data get entity @s Pos[1]
execute if score #state survisland.data matches 1 store result score #dest_z survisland.data run data get entity @s Pos[2]
kill @s

