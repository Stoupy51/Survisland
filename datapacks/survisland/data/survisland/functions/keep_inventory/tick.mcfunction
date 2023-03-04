
## Statements checking
scoreboard players operation #predicate survisland.id = @s survisland.id
scoreboard players set #state survisland.data 0

# Check if the player is dead
execute if score #state survisland.data matches 0 as @a[scores={survisland.deathCount=1..},predicate=survisland:has_same_id,gamemode=!creative,gamemode=!spectator] run function survisland:keep_inventory/player_died


## States
# 1 = Player is dead
# 2 = Player is dead and there are items to drop
execute unless score #keepInventory survisland.data matches 1 if score #state survisland.data matches 2 run data modify storage survisland:main copy set from storage survisland:main newInventory
execute unless score #keepInventory survisland.data matches 1 if score #state survisland.data matches 2 run function survisland:keep_inventory/drop_inventory/


## Teleport to the player or 0 0 0 if the player is dead
execute store success score #success survisland.data run tp @s @e[type=player,predicate=survisland:has_same_id,limit=1]
execute if score #success survisland.data matches 0 run tp @s 0 0 0


