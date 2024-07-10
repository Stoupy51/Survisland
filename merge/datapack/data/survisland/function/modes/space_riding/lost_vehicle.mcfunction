
# Add points
scoreboard players add #unride_points survisland.data 1
scoreboard players operation @s survisland.temp.sidebar += #unride_points survisland.data

# Annonce
tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" "},{"selector":"@s"},{"text":" a perdu sa monture !"}]
execute as @a at @s run function survisland:sounds/experience_orb.pickup

# Remove alive tag
tag @s remove survisland.alive

# Clear arrows
clear @s arrow

