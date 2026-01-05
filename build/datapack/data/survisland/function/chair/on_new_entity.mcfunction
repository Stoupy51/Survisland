
#> survisland:chair/on_new_entity
#
# @executed	align xyz & positioned ~.5 ~ ~.5
#
# @within	survisland:chair/summon [ align xyz & positioned ~.5 ~ ~.5 ]
#

# Add the chair tag
tag @s add survisland.chair

# Modify rotation and height
data modify entity @s Rotation set from storage survisland:temp Rotation
data modify entity @s height set value 0.05f

# Playsound
playsound block.wood.place block @a[distance=..20]
particle happy_villager ~ ~ ~ 0.25 0.0 0.25 0 100

