
#> survisland:modes/quake/respawn
#
# @executed	as @e[tag=...] & at @s
#
# @within	survisland:modes/quake/shooted_player
#

# Get the respawn point with the highest distance to a player
execute as @e[tag=survisland.quake_respawn] at @s run function survisland:modes/quake/get_player_distance
scoreboard players set #max survisland.data 0
scoreboard players operation #max survisland.data > @e[tag=survisland.quake_respawn] survisland.data
execute as @e[tag=survisland.quake_respawn] if score @s survisland.data = #max survisland.data run tag @s add survisland.quake_respawn_max

# Teleport the player to the respawn point
tp @s @e[tag=survisland.quake_respawn_max,limit=1]
tag @e[tag=survisland.quake_respawn_max,limit=1] remove survisland.quake_respawn_max

