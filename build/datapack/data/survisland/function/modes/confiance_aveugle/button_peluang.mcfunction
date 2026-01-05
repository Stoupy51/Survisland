
#> survisland:modes/confiance_aveugle/button_peluang
#
# @executed	positioned -1205 60 -2749
#
# @within	survisland:modes/confiance_aveugle/tick [ positioned -1205 60 -2749 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1205 60 -2733 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1226 62 -2763 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1226 62 -2747 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1241 62 -2763 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1241 62 -2747 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1248 61 -2749 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1248 61 -2733 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1256 68 -2762 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1256 68 -2746 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1264 66 -2749 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1264 66 -2733 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1267 59 -2763 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1267 59 -2747 ]
#

scoreboard players add #mPeluang_buttons survisland.data 1
execute as @a at @s run playsound entity.experience_orb.pickup ambient @s
tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Un bouton a été activé par l'équipe "},{"text":"Peluang","color":"aqua"}]
setblock ~ ~ ~ air

execute if score #mPeluang_buttons survisland.data matches 2 run fill -1211 59 -2763 -1211 56 -2733 air replace oak_fence
execute if score #mPeluang_buttons survisland.data matches 4 run fill -1231 60 -2763 -1231 57 -2733 air replace oak_fence
execute if score #mPeluang_buttons survisland.data matches 8 run fill -1251 61 -2763 -1251 58 -2733 air replace oak_fence
execute if score #mPeluang_buttons survisland.data matches 14 run fill -1268 66 -2751 -1268 64 -2734 air replace oak_fence
function survisland:modes/confiance_aveugle/update_sidebar

