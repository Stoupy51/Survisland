
scoreboard players add #mPeluang_buttons survisland.data 1
execute as @a at @s run playsound entity.experience_orb.pickup ambient @s
tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Un bouton a été activé par l'équipe "},{"text":"Peluang","color":"aqua"}]
clear @s stone_button[minecraft:custom_data={survisland:{button:1b}}] 1
setblock ~ ~ ~ light

execute if score #mPeluang_buttons survisland.data matches 4 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" 1ère salle complétée par l'équipe "},{"text":"Peluang","color":"aqua"},{"text":" !"}]
execute if score #mPeluang_buttons survisland.data matches 8 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" 2ème salle complétée par l'équipe "},{"text":"Peluang","color":"aqua"},{"text":" !"}]
execute if score #mPeluang_buttons survisland.data matches 12 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" 3ème salle complétée par l'équipe "},{"text":"Peluang","color":"aqua"},{"text":" !"}]
execute if score #mPeluang_buttons survisland.data matches 16 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" 4ème salle complétée par l'équipe "},{"text":"Peluang","color":"aqua"},{"text":" !"}]
execute if score #mPeluang_buttons survisland.data matches 20 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Tous les boutons ont été validés par l'équipe "},{"text":"Peluang","color":"aqua"},{"text":" ! Plus qu'à se diriger sur le toit de la tour !"}]

execute if score #mPeluang_buttons survisland.data matches 16 run data modify block -1251 51 -2758 auto set value 0b
execute if score #mPeluang_buttons survisland.data matches 16 run data modify block -1239 51 -2758 auto set value 0b
execute if score #mPeluang_buttons survisland.data matches 16 run data modify block -1227 51 -2758 auto set value 0b
execute if score #mPeluang_buttons survisland.data matches 16 run data modify block -1215 51 -2758 auto set value 0b

function survisland:modes/find_that_button/update_sidebar

