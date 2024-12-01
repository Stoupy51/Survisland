
#> survisland:keep_inventory/remove_items/
#
# @input storage survisland:main Inventory
#
# @output storage survisland:main newInventory
#
# Remove items from storage survisland:main Inventory that are in the 0 1 0 chest
# using the following algorithm:
## create a new empty inventory
## for every items in the inventory
##     if the item in the chest is the same as the item in the inventory
##          don't add the item to the new inventory
##     else
##          add the item to the new inventory

# Copy chest items
data modify storage survisland:main newInventory set value []

# Loop through all items in the inventory
execute if data storage survisland:main Inventory[0] run function survisland:keep_inventory/remove_items/loop_inventory

# Remove every items of player inventory that is in the new inventory
data modify storage survisland:main Inventory set from storage survisland:main newInventory
execute if data storage survisland:main Inventory[0] run function survisland:keep_inventory/remove_items/loop_player_inventory

