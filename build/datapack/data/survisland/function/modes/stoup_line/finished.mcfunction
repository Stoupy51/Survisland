
#> survisland:modes/stoup_line/finished
#
# @within	(public)
#

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" "},{"selector":"@s"},{"text":" vient de terminer l'épreuve !"}]
execute as @a at @s run function survisland:sounds/player.level_up
scoreboard players set @s survisland.temp.sidebar 100

