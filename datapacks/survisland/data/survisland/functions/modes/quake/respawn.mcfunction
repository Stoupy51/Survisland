
# Get the respawn point with the lowest distance to a player
execute as @e[tag=survisland.quake_respawn] at @s run function survisland:modes/quake/get_player_distance
scoreboard players operation #min survisland.data < @e[tag=survisland.quake_respawn] survisland.data
execute as @e[tag=survisland.quake_respawn] if score @s survisland.data = #min survisland.data run tag @s add survisland.quake_respawn_min

# Teleport the player to the respawn point
tp @s @e[tag=survisland.quake_respawn_min,limit=1]
tag @e[tag=survisland.quake_respawn_min,limit=1] remove survisland.quake_respawn_min

