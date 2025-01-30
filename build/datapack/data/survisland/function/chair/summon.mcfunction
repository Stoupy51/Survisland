
#> survisland:chair/summon
#
# @within	???
#

data modify storage survisland:temp Rotation set from entity @s Rotation
execute align xyz positioned ~.5 ~ ~.5 summon interaction run function survisland:chair/on_new_entity

