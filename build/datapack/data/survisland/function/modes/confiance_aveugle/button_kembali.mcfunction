
#> survisland:modes/confiance_aveugle/button_kembali
#
# @executed	positioned -1205 60 -2815
#
# @within	survisland:modes/confiance_aveugle/tick [ positioned -1205 60 -2815 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1205 60 -2799 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1226 62 -2829 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1226 62 -2813 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1241 62 -2829 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1241 62 -2813 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1248 61 -2815 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1248 61 -2799 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1256 68 -2828 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1256 68 -2812 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1264 66 -2815 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1264 66 -2799 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1267 59 -2829 ]
#			survisland:modes/confiance_aveugle/tick [ positioned -1267 59 -2813 ]
#

scoreboard players add #mKembali_buttons survisland.data 1
execute as @a at @s run playsound entity.experience_orb.pickup ambient @s
tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Un bouton a été activé par l'équipe "},{"text":"Kembali","color":"yellow"}]
setblock ~ ~ ~ air

execute if score #mKembali_buttons survisland.data matches 2 run fill -1211 59 -2829 -1211 56 -2799 air replace oak_fence
execute if score #mKembali_buttons survisland.data matches 4 run fill -1231 60 -2829 -1231 57 -2799 air replace oak_fence
execute if score #mKembali_buttons survisland.data matches 8 run fill -1251 61 -2829 -1251 58 -2799 air replace oak_fence
execute if score #mKembali_buttons survisland.data matches 14 run fill -1268 66 -2817 -1268 64 -2800 air replace oak_fence
function survisland:modes/confiance_aveugle/update_sidebar

