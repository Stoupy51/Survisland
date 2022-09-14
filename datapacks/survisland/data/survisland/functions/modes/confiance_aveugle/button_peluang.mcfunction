
scoreboard players add #mPeluang_buttons survisland.data 1
execute as @a at @s run playsound entity.experience_orb.pickup ambient @s
tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Un bouton a été activé par l'équipe "},{"text":"Peluang","color":"aqua"}]
setblock ~ ~ ~ air

execute if score #mPeluang_buttons survisland.data matches 2 run fill -1211 59 -2796 -1211 56 -2766 air replace oak_fence
execute if score #mPeluang_buttons survisland.data matches 4 run fill -1231 60 -2796 -1231 57 -2766 air replace oak_fence
execute if score #mPeluang_buttons survisland.data matches 8 run fill -1251 61 -2796 -1251 58 -2766 air replace oak_fence
execute if score #mPeluang_buttons survisland.data matches 14 run fill -1268 66 -2808 -1268 64 -2791 air replace oak_fence
function survisland:modes/confiance_aveugle/update_sidebar

