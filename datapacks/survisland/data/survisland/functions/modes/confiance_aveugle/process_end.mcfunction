
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 unless score #mAkijan_restants survisland.data matches 0 if score #mHainy_restants survisland.data matches 0 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin du Layers avec une victoire de l'équipe Akijan : "},{"selector":"@a[team=mAkijan,sort=random]"}]
execute if score #process_end survisland.data matches 1 unless score #mHainy_restants survisland.data matches 0 if score #mAkijan_restants survisland.data matches 0 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin du Layers avec une victoire de l'équipe Hainy : "},{"selector":"@a[team=mHainy,sort=random]"}]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mAkijan]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mHainy]
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] slow_falling 20 0 true
execute if score #process_end survisland.data matches 1 as @a at @s run playsound entity.wither.death ambient @s

#Autodestruction ?
#execute if score #process_end survisland.data matches 2 run fill -1205 114 -2815 -1241 114 -2753 air

#TODO : Detection de fin, tests

execute if score #process_end survisland.data matches 100 run function survisland:modes/confiance_aveugle/stop
