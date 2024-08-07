
#> survisland:modes/take_that_pig/parkour_end
#
# @within	survisland:modes/take_that_pig/second
#

tag @s add survisland.finished
execute as @a at @s run playsound entity.player.levelup ambient @s
execute if score #pos survisland.data matches 1 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" "},{"selector":"@s"},{"text":" a terminé le parcours en "},{"score":{"name":"#pos","objective":"survisland.data"},"color":"yellow"},{"text":"ère position !"}]
execute if score #pos survisland.data matches 2.. run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" "},{"selector":"@s"},{"text":" a terminé le parcours en "},{"score":{"name":"#pos","objective":"survisland.data"},"color":"yellow"},{"text":"ème position !"}]
scoreboard players add #pos survisland.data 1

scoreboard players operation @s survisland.temp.sidebar *= #mult survisland.data
scoreboard players operation @s survisland.temp.sidebar /= #100 survisland.data
scoreboard players remove #mult survisland.data 1

