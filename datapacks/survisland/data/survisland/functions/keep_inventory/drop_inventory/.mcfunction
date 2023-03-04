
#> survisland:keep_inventory/drop_inventory/
#
# @input storage survisland:main newInventory
#
# Drop every item of the storage "newInventory" recursively

# Summon a loot spawn and replace the item with the item in the storage
loot spawn ~ ~ ~ loot survisland:temp_item
execute as @e[type=item,nbt={Item:{tag:{survisland:{temp_item:1b}}}}] run data modify entity @s Item set from storage survisland:main newInventory[0]

# Loop again
data remove storage survisland:main newInventory[0]
execute if data storage survisland:main newInventory[0] run function survisland:keep_inventory/drop_inventory/

