
schedule function survisland:modes/skateboard/tick 1t replace

# Mount
execute as @a[gamemode=!spectator,tag=!survisland.skateboard] at @s if block ~ ~-1 ~ blue_concrete positioned ~ ~2 ~ if entity @a[gamemode=!spectator,tag=!survisland.skateboard,distance=..1] run function survisland:modes/skateboard/ride

# Dismount
execute as @a[tag=survisland.skateboard] at @s positioned ~ ~2 ~ unless entity @a[tag=survisland.skateboard,distance=..1.5] positioned ~ ~-4 ~ unless entity @a[tag=survisland.skateboard,distance=..1.5] run tag @s remove survisland.skateboard

# Move
execute as @a[tag=survisland.skateboard] at @s if block ~ ~-1 ~ blue_stained_glass positioned ~ ~-2 ~ run tp @p[tag=survisland.skateboard,distance=..1.5] ~ ~ ~
execute as @a[tag=survisland.skateboard] at @s if block ~ ~-1 ~ red_concrete positioned ~ ~2 ~ run tp @p[tag=survisland.skateboard,distance=..1.5] ~ ~ ~

