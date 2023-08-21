
#> survisland:utils/pendent_switch
#
# @within			survisland:advancements/inventory_changed
# @executed			as & at the player
#
# @description		Change le model data du pendent lorsqu'il est dans la main gauche ou non
#

# Copy du pendent dans un slot temporaire
setblock 0 5 0 air
setblock 0 5 0 barrel
execute if data entity @s SelectedItem.tag{CustomModelData:2010009} run item replace block 0 5 0 container.0 from entity @s weapon.mainhand
execute if data entity @s Inventory[{Slot:-106b}].tag{CustomModelData:2010008} run item replace block 0 5 0 container.0 from entity @s weapon.offhand

# Inversion du model data du pendent
execute if data entity @s SelectedItem.tag{CustomModelData:2010009} run data modify block 0 5 0 Items[0].tag.CustomModelData set value 2010008
execute if data entity @s Inventory[{Slot:-106b}].tag{CustomModelData:2010008} run data modify block 0 5 0 Items[0].tag.CustomModelData set value 2010009

# Recopie du pendent dans la main gauche
execute if data entity @s SelectedItem.tag{CustomModelData:2010009} run item replace entity @s weapon.mainhand from block 0 5 0 container.0
execute if data entity @s Inventory[{Slot:-106b}].tag{CustomModelData:2010008} run item replace entity @s weapon.offhand from block 0 5 0 container.0

# Suppression du slot temporaire
setblock 0 5 0 air


