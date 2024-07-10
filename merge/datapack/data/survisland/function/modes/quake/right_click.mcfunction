
scoreboard players reset @s survisland.right_click
scoreboard players add @s survisland.temp.cooldown 0
execute if data entity @s SelectedItem.components."minecraft:custom_data".quake if score @s survisland.temp.cooldown matches 0 run function survisland:modes/quake/shoot

