
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve, tous les joueurs ont été trouvés !"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve, temps écoulé !"}]
execute if score #process_end survisland.data matches 1 as @a[team=mKuning,tag=survisland.alive] run scoreboard players add #mKuning_points survisland.data 20
execute if score #process_end survisland.data matches 1 as @a[team=mMayra,tag=survisland.alive] run scoreboard players add #mMayra_points survisland.data 20
execute if score #process_end survisland.data matches 1 run function survisland:modes/cache_s12/update_sidebar_points
execute if score #process_end survisland.data matches 1 if score #mKuning_points survisland.data = #mMayra_points survisland.data run scoreboard players set #detect_end survisland.data 5
execute if score #process_end survisland.data matches 1 if score #mKuning_points survisland.data > #mMayra_points survisland.data run scoreboard players set #detect_end survisland.data 4
execute if score #process_end survisland.data matches 1 if score #mKuning_points survisland.data < #mMayra_points survisland.data run scoreboard players set #detect_end survisland.data 3
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 5 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de....., wait....., égalité des points !"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 4 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de l'équipe Kuning : "},{"selector":"@a[team=mKuning,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de l'équipe Mayra : "},{"selector":"@a[team=mMayra,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 4 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;15728148]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;15739434]}]}}}}

execute if score #process_end survisland.data matches 1 run schedule clear survisland:modes/cache_s12/second
execute if score #process_end survisland.data matches 1 as @a at @s run function survisland:sounds/toast.challenge_complete

execute if score #process_end survisland.data matches 1 run effect clear @a
execute if score #process_end survisland.data matches 1 run effect give @a slow_falling 20 1 true
execute if score #process_end survisland.data matches 1 run effect give @a saturation 20 255 true
execute if score #process_end survisland.data matches 1 run gamemode spectator @a[team=!mKuning,team=!mMayra,gamemode=!creative]
execute if score #process_end survisland.data matches 1 run gamemode adventure @a[team=mKuning]
execute if score #process_end survisland.data matches 1 run gamemode adventure @a[team=mMayra]

execute if score #process_end survisland.data matches 6000 run function survisland:modes/cache_s12/stop

