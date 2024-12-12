
#> survisland:v2.1.2/load/valid_dependencies
#
# @within	survisland:v2.1.2/load/secondary
#			survisland:v2.1.2/load/valid_dependencies 1t replace
#

# Waiting for a player to get the game version, but stop function if no player found
execute unless entity @p run schedule function survisland:v2.1.2/load/valid_dependencies 1t replace
execute unless entity @p run return 0
execute store result score #game_version survisland.data run data get entity @p DataVersion

# Check if the game version is supported
scoreboard players set #mcload_error survisland.data 0
execute unless score #game_version survisland.data matches 4082.. run scoreboard players set #mcload_error survisland.data 1

# Decode errors
execute if score #mcload_error survisland.data matches 1 run tellraw @a {"text":"Survisland Error: This version is made for Minecraft 1.21.4+.","color":"red"}
execute if score #dependency_error survisland.data matches 1 run tellraw @a {"text":"Survisland Error: Libraries are missing\nplease download the right Survisland datapack\nor download each of these libraries one by one:","color":"red"}
execute if score #dependency_error survisland.data matches 1 unless score #smithed.crafter.major load.status matches 0.. run tellraw @a {"text":"- [Smithed Crafter (v0.6.2+)]","color":"gold","clickEvent":{"action":"open_url","value":"https://wiki.smithed.dev/libraries/crafter/"}}
execute if score #dependency_error survisland.data matches 1 if score #smithed.crafter.major load.status matches 0 unless score #smithed.crafter.minor load.status matches 6.. run tellraw @a {"text":"- [Smithed Crafter (v0.6.2+)]","color":"gold","clickEvent":{"action":"open_url","value":"https://wiki.smithed.dev/libraries/crafter/"}}
execute if score #dependency_error survisland.data matches 1 if score #smithed.crafter.major load.status matches 0 if score #smithed.crafter.minor load.status matches 6 unless score #smithed.crafter.patch load.status matches 2.. run tellraw @a {"text":"- [Smithed Crafter (v0.6.2+)]","color":"gold","clickEvent":{"action":"open_url","value":"https://wiki.smithed.dev/libraries/crafter/"}}

# Load Survisland
execute if score #game_version survisland.data matches 1.. if score #mcload_error survisland.data matches 0 if score #dependency_error survisland.data matches 0 run function survisland:v2.1.2/load/confirm_load

