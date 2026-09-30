
#> survisland:v2.9.0/load/valid_dependencies
#
# @within	survisland:v2.9.0/load/secondary
#			survisland:v2.9.0/load/valid_dependencies 1t replace [ scheduled ]
#

# Waiting for a player to get the game version, but stop function if no player found
execute unless entity @p run return run schedule function survisland:v2.9.0/load/valid_dependencies 1t replace
execute store result score #game_version survisland.data run data get entity @p DataVersion

# Check if the game version is supported
scoreboard players set #mcload_error survisland.data 0
execute unless score #game_version survisland.data matches 4903.. run scoreboard players set #mcload_error survisland.data 1

# Decode errors
execute if score #mcload_error survisland.data matches 1 run tellraw @a {"text":"Survisland Error: This version is made for Minecraft 26.2+.","color":"red"}
execute if score #dependency_error survisland.data matches 1 run tellraw @a {"text":"Survisland Error: Libraries are missing\nplease download the right Survisland datapack\nor download each of these libraries one by one:","color":"red"}

# Load Survisland
execute if score #game_version survisland.data matches 1.. if score #mcload_error survisland.data matches 0 if score #dependency_error survisland.data matches 0 run function survisland:v2.9.0/load/confirm_load

