
#> survisland:modes/cache_cache/process_end
#
# @within	survisland:modes/cache_cache/tick
#

scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve, tous les joueurs ont été trouvés !"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve, temps écoulé !"}]
execute if score #process_end survisland.data matches 1 as @a[team=mAkijan,tag=survisland.alive] run scoreboard players add #mAkijan_points survisland.data 20
execute if score #process_end survisland.data matches 1 as @a[team=mHainy,tag=survisland.alive] run scoreboard players add #mHainy_points survisland.data 20
execute if score #process_end survisland.data matches 1 run function survisland:modes/cache_cache/update_sidebar_points
execute if score #process_end survisland.data matches 1 if score #mAkijan_points survisland.data = #mHainy_points survisland.data run scoreboard players set #detect_end survisland.data 5
execute if score #process_end survisland.data matches 1 if score #mAkijan_points survisland.data > #mHainy_points survisland.data run scoreboard players set #detect_end survisland.data 4
execute if score #process_end survisland.data matches 1 if score #mAkijan_points survisland.data < #mHainy_points survisland.data run scoreboard players set #detect_end survisland.data 3
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 5 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de....., wait....., égalité des points !"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 4 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de l'équipe Akijan : "},{"selector":"@a[team=mAkijan,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de l'équipe Hainy : "},{"selector":"@a[team=mHainy,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 4 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;22187]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;1113924]}]}}}}

execute if score #process_end survisland.data matches 1 run schedule clear survisland:modes/cache_cache/second
execute if score #process_end survisland.data matches 1 as @a at @s run playsound entity.wither.death ambient @s

execute if score #process_end survisland.data matches 1 run effect clear @a[gamemode=survival] blindness
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] slow_falling 20 1 true
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] saturation 20 255 true
execute if score #process_end survisland.data matches 1 run gamemode spectator @a[team=!mAkijan,team=!mHainy,gamemode=!creative]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mAkijan]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mHainy]

execute if score #process_end survisland.data matches 6000 run function survisland:modes/cache_cache/stop

