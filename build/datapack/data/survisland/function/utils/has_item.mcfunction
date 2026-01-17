
#> survisland:utils/has_item
#
# @executed	as the player & at current position
#
# @within	survisland:advancements/inventory_changed {"item":"pendent"}
#			survisland:advancements/inventory_changed {"item":"pendent_held"}
#			survisland:advancements/inventory_changed {"item":"dragon_necklace"}
#			survisland:advancements/inventory_changed {"item":"dragon_flower_necklace"}
#
# @args		item (string)
#

# Check if player has item in inventory
$execute if items entity @s container.* *[custom_data~{survisland:{"$(item)":true}}] run return 1
$execute if items entity @s player.cursor *[custom_data~{survisland:{"$(item)":true}}] run return 1
$execute if items entity @s armor.* *[custom_data~{survisland:{"$(item)":true}}] run return 1
$execute if items entity @s weapon.* *[custom_data~{survisland:{"$(item)":true}}] run return 1
$execute if items entity @s enderchest.* *[custom_data~{survisland:{"$(item)":true}}] run return 1
$execute if items entity @s player.crafting.* *[custom_data~{survisland:{"$(item)":true}}] run return 1
$execute if data entity @s Inventory[].components."minecraft:custom_data".survisland.$(item) run return 1
return fail

