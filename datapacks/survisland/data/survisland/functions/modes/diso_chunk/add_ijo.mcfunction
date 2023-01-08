

scoreboard players add #mIjo survisland.data 1
execute if score #mIjo survisland.data matches ..5 as @a at @s run function survisland:sounds/player.level_up
tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Progrès de l'équipe "},{"text":"Ijo","color":"yellow"},{"text":" : "},{"text":"[","color":"aqua"},{"score":{"name":"#mIjo","objective":"survisland.data"},"color":"yellow"},{"text":"/"},{"text":"6","color":"yellow"},{"text":"]","color":"aqua"}]

execute if score #mIjo survisland.data matches 6 run scoreboard players add #diso_pos survisland.data 1
execute if score #mIjo survisland.data matches 6 as @a at @s run function survisland:sounds/wither.death
execute if score #mIjo survisland.data matches 6 if score #diso_pos survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" L'équipe "},{"text":"Ijo","color":"yellow"},{"text":" vient de terminer "},{"score":{"name":"#diso_pos","objective":"survisland.data"},"color":"aqua"},{"text":"ère"}]
execute if score #mIjo survisland.data matches 6 if score #diso_pos survisland.data matches 2.. run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" L'équipe "},{"text":"Ijo","color":"yellow"},{"text":" vient de terminer "},{"score":{"name":"#diso_pos","objective":"survisland.data"},"color":"aqua"},{"text":"ème"}]

