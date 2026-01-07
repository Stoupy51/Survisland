
#> survisland:v2.4.1/load/check_dependencies
#
# @within	survisland:v2.4.1/load/secondary
#

## Check if Survisland is loadable (dependencies)
scoreboard players set #dependency_error survisland.data 0
execute if score #dependency_error survisland.data matches 0 unless score #furnace_nbt_recipes.major load.status matches 1.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score #furnace_nbt_recipes.major load.status matches 1 unless score #furnace_nbt_recipes.minor load.status matches 10.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score #furnace_nbt_recipes.major load.status matches 1 if score #furnace_nbt_recipes.minor load.status matches 10 unless score #furnace_nbt_recipes.patch load.status matches 1.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.bitwise.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.bitwise.major load.status matches 3 unless score $bs.bitwise.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.block.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.block.major load.status matches 3 unless score $bs.block.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.color.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.color.major load.status matches 3 unless score $bs.color.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.dump.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.dump.major load.status matches 3 unless score $bs.dump.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.environment.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.environment.major load.status matches 3 unless score $bs.environment.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.generation.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.generation.major load.status matches 3 unless score $bs.generation.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.health.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.health.major load.status matches 3 unless score $bs.health.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.hitbox.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.hitbox.major load.status matches 3 unless score $bs.hitbox.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.id.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.id.major load.status matches 3 unless score $bs.id.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.interaction.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.interaction.major load.status matches 3 unless score $bs.interaction.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.link.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.link.major load.status matches 3 unless score $bs.link.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.log.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.log.major load.status matches 3 unless score $bs.log.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.math.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.math.major load.status matches 3 unless score $bs.math.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.move.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.move.major load.status matches 3 unless score $bs.move.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.position.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.position.major load.status matches 3 unless score $bs.position.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.random.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.random.major load.status matches 3 unless score $bs.random.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.raycast.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.raycast.major load.status matches 3 unless score $bs.raycast.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.schedule.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.schedule.major load.status matches 3 unless score $bs.schedule.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.sidebar.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.sidebar.major load.status matches 3 unless score $bs.sidebar.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.spline.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.spline.major load.status matches 3 unless score $bs.spline.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.string.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.string.major load.status matches 3 unless score $bs.string.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.time.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.time.major load.status matches 3 unless score $bs.time.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.tree.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.tree.major load.status matches 3 unless score $bs.tree.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.vector.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.vector.major load.status matches 3 unless score $bs.vector.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.view.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.view.major load.status matches 3 unless score $bs.view.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 unless score $bs.xp.major load.status matches 3.. run scoreboard players set #dependency_error survisland.data 1
execute if score #dependency_error survisland.data matches 0 if score $bs.xp.major load.status matches 3 unless score $bs.xp.minor load.status matches 2.. run scoreboard players set #dependency_error survisland.data 1

