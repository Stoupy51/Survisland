
# Compare Inventory[0] to Chest[0]
data modify storage survisland:main temp set from storage survisland:main Inventory[0]
data remove storage survisland:main temp.Slot
data remove storage survisland:main temp.Count
data remove storage survisland:main Chest[0].Slot
data remove storage survisland:main Chest[0].Count
execute store success score #not_in_chest survisland.data run data modify storage survisland:main Chest[0] set from storage survisland:main temp

# Loop again
data remove storage survisland:main Chest[0]
execute if score #not_in_chest survisland.data matches 1 if data storage survisland:main Chest[0] run function survisland:keep_inventory/remove_items/loop_chest

