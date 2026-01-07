
#> survisland:calls/furnace_nbt_recipes/smoking_recipes
#
# @within	#furnace_nbt_recipes:v1/smoking_recipes
#

execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input{"components": {"minecraft:custom_data": {"survisland": {"rice": true}}}} run loot replace block ~ ~ ~ container.3 loot survisland:i/cooked_rice
execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input{"item": "minecraft:bread"} run loot replace block ~ ~ ~ container.3 loot survisland:i/croissant

