
#> survisland:modes/space_riding/lost_vehicle
#
# @executed	as @a[gamemode=adventure,tag=survisland.alive,predicate=!survisland:has_vehicle,sort=random]
#
# @within	survisland:modes/space_riding/tick [ as @a[gamemode=adventure,tag=survisland.alive,predicate=!survisland:has_vehicle,sort=random] ]
#

# Add points
scoreboard players add #unride_points survisland.data 1
scoreboard players operation @s survisland.temp.sidebar += #unride_points survisland.data

# Annonce
tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" "},{"selector":"@s"},{"translate": "survisland.a_perdu_sa_monture"}]
execute as @a at @s run function survisland:sounds/experience_orb.pickup

# Remove alive tag
tag @s remove survisland.alive

# Clear arrows
clear @s arrow

