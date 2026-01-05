
#> survisland:keep_inventory/remove_items/loop_inventory
#
# @within	survisland:keep_inventory/remove_items/loop_inventory
#			survisland:keep_inventory/remove_items/main
#

# Loop through all items in the chest
data modify storage survisland:main Chest set from block 0 1 0 Items
scoreboard players set #not_in_chest survisland.data 1
execute if data storage survisland:main Chest[0] run function survisland:keep_inventory/remove_items/loop_chest
execute if score #not_in_chest survisland.data matches 1 run data modify storage survisland:main newInventory append from storage survisland:main Inventory[0]

# Loop again
data remove storage survisland:main Inventory[0]
execute if data storage survisland:main Inventory[0] run function survisland:keep_inventory/remove_items/loop_inventory

