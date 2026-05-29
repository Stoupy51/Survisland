
# Extend the storage with the chest items
data modify storage survisland:main AllChests append from block ~ ~ ~ Items[]

# Continue looping
execute positioned ~ ~-1 ~ if data block ~ ~ ~ Items run function survisland:keep_inventory/get_chest_items

