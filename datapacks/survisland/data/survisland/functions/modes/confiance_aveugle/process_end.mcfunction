
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve de Confiance Aveugle avec une victoire de l'équipe Kembali : "},{"selector":"@a[team=mKembali,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve de Confiance Aveugle avec une victoire de l'équipe Tuarua : "},{"selector":"@a[team=mTuarua,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve de Confiance Aveugle avec une victoire de l'équipe Peluang : "},{"selector":"@a[team=mPeluang,sort=random]"}]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[gamemode=adventure]
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] slow_falling 20 0 true
execute if score #process_end survisland.data matches 1 as @a at @s run playsound entity.wither.death ambient @s

#Autodestruction ?
#execute if score #process_end survisland.data matches 2 run fill -1205 114 -2815 -1241 114 -2753 air

#TODO : Detection de fin, tests

execute if score #process_end survisland.data matches 100 run function survisland:modes/confiance_aveugle/stop

