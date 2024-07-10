
#> survisland:utils/pendent_switch
#
# @within	survisland:advancements/inventory_changed
#

# Copy du pendent dans un slot temporaire
setblock 0 5 0 air
setblock 0 5 0 barrel
execute if data entity @s SelectedItem.components{"minecraft:custom_model_data":2010008} run item replace block 0 5 0 container.0 from entity @s weapon.mainhand
execute if data entity @s Inventory[{Slot:-106b}].components{"minecraft:custom_model_data":2010007} run item replace block 0 5 0 container.0 from entity @s weapon.offhand

# Inversion du model data du pendent
execute if data entity @s SelectedItem.components{"minecraft:custom_model_data":2010008} run data modify block 0 5 0 Items[0].components."minecraft:custom_model_data" set value 2010007
execute if data entity @s Inventory[{Slot:-106b}].components{"minecraft:custom_model_data":2010007} run data modify block 0 5 0 Items[0].components."minecraft:custom_model_data" set value 2010008

# Recopie du pendent dans la main gauche
execute if data entity @s SelectedItem.components{"minecraft:custom_model_data":2010008} run item replace entity @s weapon.mainhand from block 0 5 0 container.0
execute if data entity @s Inventory[{Slot:-106b}].components{"minecraft:custom_model_data":2010007} run item replace entity @s weapon.offhand from block 0 5 0 container.0

# Suppression du slot temporaire
setblock 0 5 0 air

