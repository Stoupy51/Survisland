
#> survisland:v2.1.5/load/valid_dependencies
#
# @within	survisland:v2.1.5/load/secondary
#			survisland:v2.1.5/load/valid_dependencies 1t replace
#

# Waiting for a player to get the game version, but stop function if no player found
execute unless entity @p run schedule function survisland:v2.1.5/load/valid_dependencies 1t replace
execute unless entity @p run return 0
execute store result score #game_version survisland.data run data get entity @p DataVersion

# Check if the game version is supported
scoreboard players set #mcload_error survisland.data 0
execute unless score #game_version survisland.data matches 4321.. run scoreboard players set #mcload_error survisland.data 1

# Decode errors
execute if score #mcload_error survisland.data matches 1 run tellraw @a {"text":"Survisland Error: This version is made for Minecraft 1.21.5+.","color":"red"}
execute if score #dependency_error survisland.data matches 1 run tellraw @a {"text":"Survisland Error: Libraries are missing\nplease download the right Survisland datapack\nor download each of these libraries one by one:","color":"red"}
execute if score #dependency_error survisland.data matches 1 unless score #furnace_nbt_recipes.major load.status matches 1.. run tellraw @a {"text":"- [Furnace NBT Recipes (v1.9.0+)]","color":"gold","click_event":{"action":"open_url","url":"https://github.com/Stoupy51/FurnaceNbtRecipes"}}
execute if score #dependency_error survisland.data matches 1 if score #furnace_nbt_recipes.major load.status matches 1 unless score #furnace_nbt_recipes.minor load.status matches 9.. run tellraw @a {"text":"- [Furnace NBT Recipes (v1.9.0+)]","color":"gold","click_event":{"action":"open_url","url":"https://github.com/Stoupy51/FurnaceNbtRecipes"}}
execute if score #dependency_error survisland.data matches 1 unless score $bs.dump.major load.status matches 3.. run tellraw @a {"text":"- [Bookshelf Dump (v3.0.0+)]","color":"gold","click_event":{"action":"open_url","url":"https://github.com/mcbookshelf/bookshelf/releases"}}
execute if score #dependency_error survisland.data matches 1 if score $bs.dump.major load.status matches 3 unless score $bs.dump.minor load.status matches 0.. run tellraw @a {"text":"- [Bookshelf Dump (v3.0.0+)]","color":"gold","click_event":{"action":"open_url","url":"https://github.com/mcbookshelf/bookshelf/releases"}}

# Load Survisland
execute if score #game_version survisland.data matches 1.. if score #mcload_error survisland.data matches 0 if score #dependency_error survisland.data matches 0 run function survisland:v2.1.5/load/confirm_load

