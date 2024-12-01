
#> survisland:advancements/inventory_changed
#
# @within	advancement survisland:inventory_changed
#

# Advancement revoke
advancement revoke @s only survisland:inventory_changed

# If pendent in left or right hand, run switch function
scoreboard players set #success survisland.data 0
execute store success score #success survisland.data if data entity @s SelectedItem.components{"minecraft:item_model":"survisland:pendent_held"} run function survisland:utils/pendent_switch
execute if score #success survisland.data matches 0 if data entity @s Inventory[{Slot:-106b}].components{"minecraft:item_model":"survisland:pendent"} run function survisland:utils/pendent_switch

