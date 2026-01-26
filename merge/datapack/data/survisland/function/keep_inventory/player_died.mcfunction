
# Reset scoreboard
scoreboard players reset @s survisland.deathCount
execute if entity @s[gamemode=!survival,gamemode=!adventure] run return fail

# Copy player inventory to storage (with armor & offhand)
data modify storage survisland:main Inventory set from entity @s Inventory
data modify storage survisland:main Inventory append from entity @s equipment.offhand
data modify storage survisland:main Inventory[-1].Slot set value -106
data modify storage survisland:main Inventory append from entity @s equipment.head
data modify storage survisland:main Inventory[-1].Slot set value 103
data modify storage survisland:main Inventory append from entity @s equipment.chest
data modify storage survisland:main Inventory[-1].Slot set value 102
data modify storage survisland:main Inventory append from entity @s equipment.legs
data modify storage survisland:main Inventory[-1].Slot set value 101
data modify storage survisland:main Inventory append from entity @s equipment.feet
data modify storage survisland:main Inventory[-1].Slot set value 100

# Remove items that are not in the 0 1 0 chest
execute unless score #keepInventory survisland.data matches 1 run function survisland:keep_inventory/remove_items/main

# Drop items if keepInventory is not enabled
data modify storage survisland:main death_location set value {dimension:"",x:0,y:0,z:0}
data modify storage survisland:main death_location.dimension set from entity @s LastDeathLocation.dimension
data modify storage survisland:main death_location.x set from entity @s LastDeathLocation.pos[0]
data modify storage survisland:main death_location.y set from entity @s LastDeathLocation.pos[1]
data modify storage survisland:main death_location.z set from entity @s LastDeathLocation.pos[2]
execute unless score #keepInventory survisland.data matches 1 if data storage survisland:main newInventory[0] run function survisland:keep_inventory/drop_inventory with storage survisland:main death_location

