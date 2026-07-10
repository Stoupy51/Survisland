
#> survisland:cushion/punch_adv
#
# @executed	as the player & at current position
#
# @within	advancement survisland:cushion_punch
#

# Advancement revoke
advancement revoke @s only survisland:cushion_punch

# Add temporary tag and find the punched cushion (the one whose last attacker is this player)
tag @s add survisland.temp
execute as @e[type=interaction,tag=survisland.cushion,distance=..50] run function survisland:cushion/compare_attacker

# Remove temporary tag
tag @s remove survisland.temp

