
#> survisland:modes/find_that_button/button_peluang
#
# @executed	as @a[team=mPeluang,nbt={Inventory:[{tag:{survisland:{button:1b}}}]}] & positioned 0 0 0
#
# @within	survisland:modes/find_that_button/tick [ as @a[team=mPeluang,nbt={Inventory:[{tag:{survisland:{button:1b}}}]}] & positioned 0 0 0 ]
#

scoreboard players add #mPeluang_buttons survisland.data 1
execute as @a at @s run playsound entity.experience_orb.pickup ambient @s
tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.un_bouton_a_t_activ_par_lquipe"},{"translate": "survisland.peluang","color":"aqua"}]
clear @s stone_button[minecraft:custom_data={survisland:{button:1b}}] 1
setblock ~ ~ ~ light

execute if score #mPeluang_buttons survisland.data matches 4 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"translate": "survisland.1re_salle_complte_par_lquipe"},{"translate": "survisland.peluang","color":"aqua"},{"text":" !"}]
execute if score #mPeluang_buttons survisland.data matches 8 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"translate": "survisland.2me_salle_complte_par_lquipe"},{"translate": "survisland.peluang","color":"aqua"},{"text":" !"}]
execute if score #mPeluang_buttons survisland.data matches 12 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"translate": "survisland.3me_salle_complte_par_lquipe"},{"translate": "survisland.peluang","color":"aqua"},{"text":" !"}]
execute if score #mPeluang_buttons survisland.data matches 16 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"translate": "survisland.4me_salle_complte_par_lquipe"},{"translate": "survisland.peluang","color":"aqua"},{"text":" !"}]
execute if score #mPeluang_buttons survisland.data matches 20 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"translate": "survisland.tous_les_boutons_ont_t_valids_par_lquipe"},{"translate": "survisland.peluang","color":"aqua"},{"translate": "survisland.plus_qu_se_diriger_sur_le_toit_de_la_tour"}]

execute if score #mPeluang_buttons survisland.data matches 16 run data modify block -1251 51 -2758 auto set value 0b
execute if score #mPeluang_buttons survisland.data matches 16 run data modify block -1239 51 -2758 auto set value 0b
execute if score #mPeluang_buttons survisland.data matches 16 run data modify block -1227 51 -2758 auto set value 0b
execute if score #mPeluang_buttons survisland.data matches 16 run data modify block -1215 51 -2758 auto set value 0b

function survisland:modes/find_that_button/update_sidebar

