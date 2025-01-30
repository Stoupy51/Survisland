
# Revoke advancement
advancement revoke @s only survisland:chair

# Add temporary tagg and copy UUID for comparison
tag @s add survisland.temp
data modify storage survisland:temp UUID set from entity @s UUID

# Find the interaction entity
execute as @e[type=interaction,distance=..50,predicate=!survisland:has_passenger,sort=nearest] run function survisland:chair/compare_player

# Remove temporary tag
tag @s remove survisland.temp

