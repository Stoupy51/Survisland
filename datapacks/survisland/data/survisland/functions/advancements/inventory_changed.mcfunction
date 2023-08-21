
#> survisland:advancements/inventory_changed
#
# @within			advancement survisland:inventory_changed
# @executed			as & at the player
#
# @description		Change le model data du pendent lorsqu'il est dans la main gauche ou non
#

# Advancement revoke
advancement revoke @s only survisland:inventory_changed

# If pendent in left or right hand, run switch function
scoreboard players set #success survisland.data 0
execute store success score #success survisland.data if data entity @s SelectedItem.tag{CustomModelData:2010009} run function survisland:utils/pendent_switch
execute if score #success survisland.data matches 0 if data entity @s Inventory[{Slot:-106b}].tag{CustomModelData:2010008} run function survisland:utils/pendent_switch

