
#> survisland:keep_inventory/drop_inventory
#
# @within	survisland:keep_inventory/drop_inventory with storage survisland:main death_location
#			survisland:keep_inventory/player_died with storage survisland:main death_location
#
# @args		dimension (string)
#			x (int)
#			y (int)
#			z (int)
#

# Summon a loot spawn and replace the item with the item in the storage
$execute in $(dimension) run loot spawn $(x) $(y) $(z) loot survisland:i/temp_item
execute as @e[type=item,nbt={Item:{components:{"minecraft:custom_data":{survisland:{temp_item:1b}}}}}] run data modify entity @s Item set from storage survisland:main newInventory[0]

# Loop again
data remove storage survisland:main newInventory[0]
execute if data storage survisland:main newInventory[0] run function survisland:keep_inventory/drop_inventory with storage survisland:main death_location

