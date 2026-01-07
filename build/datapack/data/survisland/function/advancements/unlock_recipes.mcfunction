
#> survisland:advancements/unlock_recipes
#
# @executed	as the player & at current position
#
# @within	advancement survisland:unlock_recipes
#

# Revoke advancement
advancement revoke @s only survisland:unlock_recipes

## For each ingredient in inventory, unlock the recipes
# minecraft:bread
scoreboard players set #success survisland.data 0
execute store success score #success survisland.data if items entity @s container.* minecraft:bread
execute if score #success survisland.data matches 1 run recipe give @s survisland:croissant
execute if score #success survisland.data matches 1 run recipe give @s survisland:croissant_2

## Add result items
execute if items entity @s container.* *[custom_data~{"survisland": {"croissant":true} }] run recipe give @s survisland:croissant
execute if items entity @s container.* *[custom_data~{"survisland": {"croissant":true} }] run recipe give @s survisland:croissant_2

