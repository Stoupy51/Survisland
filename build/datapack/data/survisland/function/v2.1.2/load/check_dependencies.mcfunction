
#> survisland:v2.1.2/load/check_dependencies
#
# @within	survisland:v2.1.2/load/secondary
#

## Check if Survisland is loadable (dependencies)
scoreboard players set #dependency_error survisland.data 0
execute if score #dependency_error survisland.data matches 0 unless score #smithed.crafter.major load.status matches 0.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score #smithed.crafter.major load.status matches 0 unless score #smithed.crafter.minor load.status matches 6.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score #smithed.crafter.major load.status matches 0 if score #smithed.crafter.minor load.status matches 6 unless score #smithed.crafter.patch load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1

