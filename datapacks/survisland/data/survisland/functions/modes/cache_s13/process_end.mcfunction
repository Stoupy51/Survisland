
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve, tous les joueurs ont été trouvés !"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve, temps écoulé !"}]
execute if score #process_end survisland.data matches 1 as @a[team=mSambor,tag=survisland.alive] run scoreboard players add #mSambor_points survisland.data 20
execute if score #process_end survisland.data matches 1 as @a[team=mKanawa,tag=survisland.alive] run scoreboard players add #mKanawa_points survisland.data 20
execute if score #process_end survisland.data matches 1 run function survisland:modes/cache_s13/update_sidebar_points
execute if score #process_end survisland.data matches 1 if score #mSambor_points survisland.data = #mKanawa_points survisland.data run scoreboard players set #detect_end survisland.data 5
execute if score #process_end survisland.data matches 1 if score #mSambor_points survisland.data > #mKanawa_points survisland.data run scoreboard players set #detect_end survisland.data 4
execute if score #process_end survisland.data matches 1 if score #mSambor_points survisland.data < #mKanawa_points survisland.data run scoreboard players set #detect_end survisland.data 3
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 5 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de....., wait....., égalité des points !"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 4 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de l'équipe Sambor : "},{"selector":"@a[team=mSambor,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de l'équipe Kanawa : "},{"selector":"@a[team=mKanawa,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 4 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;16777215]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;0]}]}}}}

execute if score #process_end survisland.data matches 1 run schedule clear survisland:modes/cache_s13/second
execute if score #process_end survisland.data matches 1 as @a at @s run function survisland:sounds/toast.challenge_complete

execute if score #process_end survisland.data matches 1 run effect clear @a
execute if score #process_end survisland.data matches 1 run effect give @a slow_falling 20 1 true
execute if score #process_end survisland.data matches 1 run effect give @a saturation 20 255 true
execute if score #process_end survisland.data matches 1 run gamemode spectator @a[team=!mSambor,team=!mKanawa,gamemode=!creative]
execute if score #process_end survisland.data matches 1 run gamemode adventure @a[team=mSambor]
execute if score #process_end survisland.data matches 1 run gamemode adventure @a[team=mKanawa]

execute if score #process_end survisland.data matches 6000 run function survisland:modes/cache_s13/stop

