
#> survisland:cushion/on_new_entity
#
# @executed	align xyz & positioned ~.5 ~1 ~.5
#
# @within	survisland:cushion/place_aimed [ align xyz & positioned ~.5 ~1 ~.5 ]
#

# Add the cushion tag, and the chair tag to reuse the sitting system
tag @s add survisland.cushion
tag @s add survisland.chair

# Modify rotation and size
data modify entity @s Rotation set from storage survisland:temp Rotation
data modify entity @s height set value 0.25f
data modify entity @s width set value 0.9f

# Playsound
playsound block.wool.place block @a[distance=..20]
particle happy_villager ~ ~ ~ 0.25 0.0 0.25 0 100

