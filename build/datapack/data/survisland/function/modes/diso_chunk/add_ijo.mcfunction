
#> survisland:modes/diso_chunk/add_ijo
#
# @within	???
#

scoreboard players add #mIjo survisland.data 1
execute if score #mIjo survisland.data matches ..5 as @a at @s run function survisland:sounds/player.level_up
tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.progrs_de_lquipe"},{"translate": "survisland.ijo","color":"dark_purple"},{"text":" : "},{"text":"[","color":"aqua"},{"score":{"name":"#mIjo","objective":"survisland.data"},"color":"yellow"},{"text":"/"},{"text":"6","color":"yellow"},{"text":"]","color":"aqua"}]

execute if score #mIjo survisland.data matches 6 run scoreboard players add #diso_pos survisland.data 1
execute if score #mIjo survisland.data matches 6 as @a at @s run function survisland:sounds/wither.death
execute if score #mIjo survisland.data matches 6 if score #diso_pos survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.lquipe"},{"translate": "survisland.ijo","color":"dark_purple"},{"translate": "survisland.vient_de_terminer"},{"score":{"name":"#diso_pos","objective":"survisland.data"},"color":"aqua"},{"text":"ère"}]
execute if score #mIjo survisland.data matches 6 if score #diso_pos survisland.data matches 2.. run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.lquipe"},{"translate": "survisland.ijo","color":"dark_purple"},{"translate": "survisland.vient_de_terminer"},{"score":{"name":"#diso_pos","objective":"survisland.data"},"color":"aqua"},{"text":"ème"}]

