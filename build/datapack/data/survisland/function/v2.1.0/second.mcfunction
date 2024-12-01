
#> survisland:v2.1.0/second
#
# @within	survisland:v2.1.0/tick
#

# Reset timer
scoreboard players set #second survisland.data 0

# Check if their marker is still there
execute as @a run function survisland:player/check_marker

# System pour les zones de gamemode adventure
function survisland:adventure_zone/second

# Disable smart ore generation from SimplEnergy
scoreboard players set _IS_ENABLED smart_ore_generation.data 0

