
scoreboard players add #mPeluang_buttons survisland.data 1
execute as @a at @s run playsound entity.experience_orb.pickup ambient @s
tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Un bouton a été activé par l'équipe "},{"text":"Peluang","color":"aqua"}]
setblock ~ ~ ~ air

execute if score #mPeluang_buttons survisland.data matches 2 run fill -1211 59 -2763 -1211 56 -2733 air replace oak_fence
execute if score #mPeluang_buttons survisland.data matches 4 run fill -1231 60 -2763 -1231 57 -2733 air replace oak_fence
execute if score #mPeluang_buttons survisland.data matches 8 run fill -1251 61 -2763 -1251 58 -2733 air replace oak_fence
execute if score #mPeluang_buttons survisland.data matches 14 run fill -1268 66 -2751 -1268 64 -2734 air replace oak_fence
function survisland:modes/confiance_aveugle/update_sidebar

