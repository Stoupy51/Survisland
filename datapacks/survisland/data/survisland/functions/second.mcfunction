
# Timer
scoreboard players set #tick survisland.data 0
scoreboard players add #second survisland.data 1
execute if score #second survisland.data matches 60.. run function survisland:minute

# Check if their marker is still there
execute as @a run function survisland:player/check_marker

# System pour les zones de gamemode adventure
function survisland:adventure_zone/second

# Clear everyone M4TOUW heads
clear @a player_head{SkullOwner:{Name:"M4TOUW"}}
clear @a player_head{SkullOwner:{Name:"M4TOUILLE"}}

# Disable smart ore generation from SimplEnergy
scoreboard players set _IS_ENABLED smart_ore_generation.data 0

