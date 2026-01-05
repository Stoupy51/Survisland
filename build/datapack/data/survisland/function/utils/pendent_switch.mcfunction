
#> survisland:utils/pendent_switch
#
# @executed	as the player & at current position
#
# @within	survisland:advancements/inventory_changed
#

# Copy du pendent dans un slot temporaire
setblock 0 5 0 air
setblock 0 5 0 barrel
execute if data entity @s SelectedItem.components{"minecraft:item_model":"survisland:pendent_held"} run item replace block 0 5 0 container.0 from entity @s weapon.mainhand
execute if data entity @s equipment.offhand.components{"minecraft:item_model":"survisland:pendent"} run item replace block 0 5 0 container.0 from entity @s weapon.offhand

# Inversion du model data du pendent
execute if data entity @s SelectedItem.components{"minecraft:item_model":"survisland:pendent_held"} run data modify block 0 5 0 Items[0].components."minecraft:item_model" set value "survisland:pendent"
execute if data entity @s equipment.offhand.components{"minecraft:item_model":"survisland:pendent"} run data modify block 0 5 0 Items[0].components."minecraft:item_model" set value "survisland:pendent_held"

# Recopie du pendent dans la main gauche
execute if data entity @s SelectedItem.components{"minecraft:item_model":"survisland:pendent_held"} run item replace entity @s weapon.mainhand from block 0 5 0 container.0
execute if data entity @s equipment.offhand.components{"minecraft:item_model":"survisland:pendent"} run item replace entity @s weapon.offhand from block 0 5 0 container.0

# Suppression du slot temporaire
setblock 0 5 0 air

