
#> survisland:keep_inventory/remove_items/loop_player_inventory
#
# @within	survisland:keep_inventory/remove_items/loop_player_inventory
#			survisland:keep_inventory/remove_items/main
#

# Remove items that matches slot
execute store result score #slot survisland.data run data get storage survisland:main Inventory[0].Slot
execute if score #slot survisland.data matches 0 run item replace entity @s hotbar.0 with air
execute if score #slot survisland.data matches 1 run item replace entity @s hotbar.1 with air
execute if score #slot survisland.data matches 2 run item replace entity @s hotbar.2 with air
execute if score #slot survisland.data matches 3 run item replace entity @s hotbar.3 with air
execute if score #slot survisland.data matches 4 run item replace entity @s hotbar.4 with air
execute if score #slot survisland.data matches 5 run item replace entity @s hotbar.5 with air
execute if score #slot survisland.data matches 6 run item replace entity @s hotbar.6 with air
execute if score #slot survisland.data matches 7 run item replace entity @s hotbar.7 with air
execute if score #slot survisland.data matches 8 run item replace entity @s hotbar.8 with air
execute if score #slot survisland.data matches 9 run item replace entity @s inventory.0 with air
execute if score #slot survisland.data matches 10 run item replace entity @s inventory.1 with air
execute if score #slot survisland.data matches 11 run item replace entity @s inventory.2 with air
execute if score #slot survisland.data matches 12 run item replace entity @s inventory.3 with air
execute if score #slot survisland.data matches 13 run item replace entity @s inventory.4 with air
execute if score #slot survisland.data matches 14 run item replace entity @s inventory.5 with air
execute if score #slot survisland.data matches 15 run item replace entity @s inventory.6 with air
execute if score #slot survisland.data matches 16 run item replace entity @s inventory.7 with air
execute if score #slot survisland.data matches 17 run item replace entity @s inventory.8 with air
execute if score #slot survisland.data matches 18 run item replace entity @s inventory.9 with air
execute if score #slot survisland.data matches 19 run item replace entity @s inventory.10 with air
execute if score #slot survisland.data matches 20 run item replace entity @s inventory.11 with air
execute if score #slot survisland.data matches 21 run item replace entity @s inventory.12 with air
execute if score #slot survisland.data matches 22 run item replace entity @s inventory.13 with air
execute if score #slot survisland.data matches 23 run item replace entity @s inventory.14 with air
execute if score #slot survisland.data matches 24 run item replace entity @s inventory.15 with air
execute if score #slot survisland.data matches 25 run item replace entity @s inventory.16 with air
execute if score #slot survisland.data matches 26 run item replace entity @s inventory.17 with air
execute if score #slot survisland.data matches 27 run item replace entity @s inventory.18 with air
execute if score #slot survisland.data matches 28 run item replace entity @s inventory.19 with air
execute if score #slot survisland.data matches 29 run item replace entity @s inventory.20 with air
execute if score #slot survisland.data matches 30 run item replace entity @s inventory.21 with air
execute if score #slot survisland.data matches 31 run item replace entity @s inventory.22 with air
execute if score #slot survisland.data matches 32 run item replace entity @s inventory.23 with air
execute if score #slot survisland.data matches 33 run item replace entity @s inventory.24 with air
execute if score #slot survisland.data matches 34 run item replace entity @s inventory.25 with air
execute if score #slot survisland.data matches 35 run item replace entity @s inventory.26 with air
execute if score #slot survisland.data matches -106 run item replace entity @s weapon.offhand with air
execute if score #slot survisland.data matches 103 run item replace entity @s armor.head with air
execute if score #slot survisland.data matches 102 run item replace entity @s armor.chest with air
execute if score #slot survisland.data matches 101 run item replace entity @s armor.legs with air
execute if score #slot survisland.data matches 100 run item replace entity @s armor.feet with air

#tellraw @s [{"score":{"name":"#slot","objective":"survisland.data"}},{"text":" "},{"storage":"survisland:main","nbt":"Inventory[0].Slot"}]

# Loop again
data remove storage survisland:main Inventory[0]
execute if data storage survisland:main Inventory[0] run function survisland:keep_inventory/remove_items/loop_player_inventory

