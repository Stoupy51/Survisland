
# Decrease the number of cinematic entities
scoreboard players remove #cinematic_entities survisland.data 1

# Restore the player's gamemode
execute at @s run tp @a[tag=survisland.temp] ~ ~-1.6 ~ ~ ~
execute if entity @s[tag=survisland.was_survival] run gamemode survival @a[tag=survisland.temp]
execute if entity @s[tag=survisland.was_adventure] run gamemode adventure @a[tag=survisland.temp]
execute if entity @s[tag=survisland.was_creative] run gamemode creative @a[tag=survisland.temp]

# Kill the entity
kill @s

