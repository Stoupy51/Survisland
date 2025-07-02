
#> survisland:utils/right_click
#
# @within	advancement survisland:right_click
#

# Advancement revoke
advancement revoke @s only survisland:right_click

# Switch case
tag @s add survisland.temp
scoreboard players set #success survisland.data 0
execute if score #success survisland.data matches 0 store success score #success survisland.data if data entity @s SelectedItem.components{"minecraft:item_model":"survisland:parchemin"} run function survisland:parchemins/deploy_open
execute if score #success survisland.data matches 0 store success score #success survisland.data if data entity @s SelectedItem.components{"minecraft:item_model":"survisland:deployed_parchemin"} run function survisland:parchemins/deploy_close
execute if score #success survisland.data matches 0 store success score #success survisland.data if data entity @s SelectedItem.components."minecraft:custom_data".survisland.snuffer positioned ^ ^ ^2 as @p[gamemode=!spectator,tag=!survisland.temp,distance=..3] at @s run function survisland:utils/snuffer
execute if score #success survisland.data matches 0 store success score #success survisland.data if data entity @s equipment.offhand.components."minecraft:custom_data".survisland.snuffer positioned ^ ^ ^2 as @p[gamemode=!spectator,distance=..3] at @s run function survisland:utils/snuffer

# Reset score and tag
scoreboard players reset @s survisland.right_click
tag @s remove survisland.temp

