
#> survisland:modes/confiance_aveugle/button_tuarua
#
# @executed	positioned -1205 60 -2782
#
# @within	survisland:modes/confiance_aveugle/tick [ positioned -1205 60 -2782 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1205 60 -2766 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1226 62 -2796 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1226 62 -2780 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1241 62 -2796 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1241 62 -2780 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1248 61 -2782 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1248 61 -2766 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1256 68 -2795 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1256 68 -2779 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1264 66 -2782 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1264 66 -2766 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1267 59 -2796 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1267 59 -2780 ]
#

scoreboard players add #mTuarua_buttons survisland.data 1
execute as @a at @s run playsound entity.experience_orb.pickup ambient @s
tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Un bouton a été activé par l'équipe "},{"text":"Tuarua","color":"light_purple"}]
setblock ~ ~ ~ air

execute if score #mTuarua_buttons survisland.data matches 2 run fill -1211 59 -2796 -1211 56 -2766 air replace oak_fence
execute if score #mTuarua_buttons survisland.data matches 4 run fill -1231 60 -2796 -1231 57 -2766 air replace oak_fence
execute if score #mTuarua_buttons survisland.data matches 8 run fill -1251 61 -2796 -1251 58 -2766 air replace oak_fence
execute if score #mTuarua_buttons survisland.data matches 14 run fill -1268 66 -2784 -1268 64 -2767 air replace oak_fence
function survisland:modes/confiance_aveugle/update_sidebar

