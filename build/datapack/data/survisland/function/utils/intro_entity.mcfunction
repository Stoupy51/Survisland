
#> survisland:utils/intro_entity
#
# @within	survisland:utils/intro_entity 1t [ scheduled ]
#			survisland:utils/intro_start
#

execute as @e[type=marker,tag=survisland.intro] at @s run function survisland:utils/intro_loop

scoreboard players add #intro survisland.data 1
execute if score #intro survisland.data matches 0.. run schedule function survisland:utils/intro_entity 1t

