
#> survisland:modes/stoup_line/finished
#
# @within	???
#

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" "},{"selector":"@s"},{"translate": "survisland.vient_de_terminer_lpreuve"}]
execute as @a at @s run function survisland:sounds/player.level_up
scoreboard players set @s survisland.temp.sidebar 100

