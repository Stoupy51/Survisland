
# Reset scoreboard
scoreboard players reset @s survisland.deathCount
execute if entity @s[gamemode=!survival,gamemode=!adventure] run return fail

# Copy player inventory to storage (with armor & offhand)
data modify storage survisland:main Inventory set from entity @s Inventory
data modify storage survisland:main equipment set from entity @s equipment
data modify storage survisland:main equipment.offhand.Slot set value -106
data modify storage survisland:main equipment.head.Slot set value 103
data modify storage survisland:main equipment.chest.Slot set value 102
data modify storage survisland:main equipment.legs.Slot set value 101
data modify storage survisland:main equipment.feet.Slot set value 100
data modify storage survisland:main Inventory append from storage survisland:main equipment.offhand
data modify storage survisland:main Inventory append from storage survisland:main equipment.head
data modify storage survisland:main Inventory append from storage survisland:main equipment.chest
data modify storage survisland:main Inventory append from storage survisland:main equipment.legs
data modify storage survisland:main Inventory append from storage survisland:main equipment.feet

# Remove items that are not in the 0 1 0 chest
execute unless score #keepInventory survisland.data matches 1 run function survisland:keep_inventory/remove_items/main

# Drop items if keepInventory is not enabled
data modify storage survisland:main death_location set value {dimension:"",x:0,y:0,z:0}
data modify storage survisland:main death_location.dimension set from entity @s LastDeathLocation.dimension
data modify storage survisland:main death_location.x set from entity @s LastDeathLocation.pos[0]
data modify storage survisland:main death_location.y set from entity @s LastDeathLocation.pos[1]
data modify storage survisland:main death_location.z set from entity @s LastDeathLocation.pos[2]
execute unless score #keepInventory survisland.data matches 1 if data storage survisland:main newInventory[0] run function survisland:keep_inventory/drop_inventory with storage survisland:main death_location

