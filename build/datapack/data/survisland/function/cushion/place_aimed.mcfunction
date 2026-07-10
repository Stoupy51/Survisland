
#> survisland:cushion/place_aimed
#
# @executed	as the player & at current position
#
# @within	survisland:cushion/place {run:"function survisland:cushion/place_aimed",with:{}}
#

# Stop if the block above the aimed block is not free
execute align xyz unless block ~ ~1 ~ #minecraft:replaceable run return fail

# Summon the cushion display and its interaction on top of the aimed block
execute align xyz positioned ~.5 ~1 ~.5 summon item_display run function survisland:cushion/on_new_display
execute align xyz positioned ~.5 ~1 ~.5 summon interaction run function survisland:cushion/on_new_entity

