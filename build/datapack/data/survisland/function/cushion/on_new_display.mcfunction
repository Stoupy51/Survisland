
#> survisland:cushion/on_new_display
#
# @executed	align xyz & positioned ~.5 ~1 ~.5
#
# @within	survisland:cushion/place_aimed [ align xyz & positioned ~.5 ~1 ~.5 ]
#

# Add the cushion tag
tag @s add survisland.cushion

# Show the used cushion item (keeps the dye color) and copy the player yaw
data modify entity @s item set from storage survisland:temp Item
data modify entity @s Rotation[0] set from storage survisland:temp Rotation[0]

# Move the model up so the cushion lies on the ground (model is centered on the entity)
data modify entity @s transformation.translation[1] set value 0.5f

