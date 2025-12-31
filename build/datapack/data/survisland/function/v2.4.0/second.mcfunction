
#> survisland:v2.4.0/second
#
# @within	survisland:v2.4.0/tick
#

# Reset timer
scoreboard players set #second survisland.data 0

# Given an ID to every player who hasn't one
execute as @a run function survisland:player/check_id

# System pour les zones de gamemode adventure
function survisland:adventure_zone/second

# Disable smart ore generation from SimplEnergy
scoreboard players set _IS_ENABLED smart_ore_generation.data 0

