
# Reset scoreboard
scoreboard players reset @s survisland.deathCount

# Copy inventory into storage and remove items that are in the 0 1 0 chest
data modify storage survisland:main Inventory set from entity @s Inventory
execute unless score #keepInventory survisland.data matches 1 run function survisland:keep_inventory/remove_items/

# Set state to 1, or 2 if there are items
scoreboard players set #state survisland.data 1
execute if data storage survisland:main newInventory run scoreboard players set #state survisland.data 2

