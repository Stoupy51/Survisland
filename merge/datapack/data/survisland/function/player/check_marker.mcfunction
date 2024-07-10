
# Launch marker summon if no marker is present
scoreboard players operation #predicate survisland.id = @s survisland.id
execute unless entity @e[type=marker,predicate=survisland:has_same_id] run function survisland:player/first_join

