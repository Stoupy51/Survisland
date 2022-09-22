
scoreboard players add #mKembali_buttons survisland.data 1
execute as @a at @s run playsound entity.experience_orb.pickup ambient @s
tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Un bouton activé par l'équipe "},{"text":"Kembali","color":"yellow"}]
setblock ~ ~ ~ light

execute if score #mKembali_buttons survisland.data matches 4 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" 1ère salle complétée par l'équipe "},{"text":"Kembali","color":"yellow"},{"text":" !"}]
execute if score #mKembali_buttons survisland.data matches 8 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" 2ème salle complétée par l'équipe "},{"text":"Kembali","color":"yellow"},{"text":" !"}]
execute if score #mKembali_buttons survisland.data matches 12 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" 3ème salle complétée par l'équipe "},{"text":"Kembali","color":"yellow"},{"text":" !"}]
execute if score #mKembali_buttons survisland.data matches 16 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" 4ème salle complétée par l'équipe "},{"text":"Kembali","color":"yellow"},{"text":" !"}]
execute if score #mKembali_buttons survisland.data matches 20 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Tous les boutons ont été validés par l'équipe "},{"text":"Kembali","color":"yellow"},{"text":" ! Plus qu'à se diriger sur le toit de la tour !"}]
execute if score #mKembali_buttons survisland.data matches 20 run data modify block -1251 51 -2818 auto set value 0b
execute if score #mKembali_buttons survisland.data matches 20 run data modify block -1239 51 -2818 auto set value 0b
execute if score #mKembali_buttons survisland.data matches 20 run data modify block -1227 51 -2818 auto set value 0b
execute if score #mKembali_buttons survisland.data matches 20 run data modify block -1215 51 -2818 auto set value 0b
function survisland:modes/find_the_button/update_sidebar

