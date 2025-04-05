
#> survisland:v2.1.5/load/check_dependencies
#
# @within	survisland:v2.1.5/load/secondary
#

## Check if Survisland is loadable (dependencies)
scoreboard players set #dependency_error survisland.data 0
execute if score #dependency_error survisland.data matches 0 unless score #furnace_nbt_recipes.major load.status matches 1.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score #furnace_nbt_recipes.major load.status matches 1 unless score #furnace_nbt_recipes.minor load.status matches 9.. run scoreboard players set #dependency_error survisland.data 1

