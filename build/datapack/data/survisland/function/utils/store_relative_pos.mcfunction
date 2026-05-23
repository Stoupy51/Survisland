
#> survisland:utils/store_relative_pos
#
# @executed	as the player & at current position
#
# @within	survisland:utils/relative
#

# Store position and kill temporary entity
data modify storage survisland:main relative_pos set from entity @s Pos
execute store result score #dest_x survisland.data run data get storage survisland:main relative_pos[0]
execute store result score #dest_y survisland.data run data get storage survisland:main relative_pos[1]
execute store result score #dest_z survisland.data run data get storage survisland:main relative_pos[2]
data remove storage survisland:main relative_pos

kill @s

