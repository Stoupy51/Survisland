
#> survisland:chair/compare_player
#
# @executed	as @e[type=interaction,distance=..50,predicate=!survisland:has_passenger,sort=nearest]
#
# @within	survisland:chair/interact_adv [ as @e[type=interaction,distance=..50,predicate=!survisland:has_passenger,sort=nearest] ]
#

# Stop if no interaction
execute unless data entity @s interaction run return fail

# Compare player with latest interaction
scoreboard players set #not_player survisland.data 1
data modify storage survisland:temp copy set from entity @s interaction.player
execute store success score #not_player survisland.data run data modify storage survisland:temp copy set from storage survisland:temp UUID

# If it's the player, mount!
execute if score #not_player survisland.data matches 0 run ride @p[tag=survisland.temp] mount @s
execute if score #not_player survisland.data matches 0 run data remove entity @s interaction

