
# Add 3 points to self
scoreboard players add @s survisland.temp.sidebar 3

# Message to show player killed
tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" +3 points pour "},{"selector":"@s"},{"text":" pour avoir tué la monture d'un joueur !"}]

