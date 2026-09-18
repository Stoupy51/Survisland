
# Extend the storage with the chest items
data modify storage survisland:main AllChests append from block ~ ~ ~ Items[]

# Continue looping
execute if score #direction survisland.data matches 0 positioned ~ ~-1 ~ if data block ~ ~ ~ Items run function survisland:keep_inventory/get_chest_items
execute if score #direction survisland.data matches 1 positioned ~ ~1 ~ if data block ~ ~ ~ Items run function survisland:keep_inventory/get_chest_items

