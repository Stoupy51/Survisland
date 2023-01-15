
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run team modify survisland.temp.sidebar.3 suffix [{"text":"Équipe Bekou : ","color":"red"},{"text":"100","color":"aqua"},{"text":"%","color":"gray"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run team modify survisland.temp.sidebar.2 suffix [{"text":"Équipe Galia : ","color":"yellow"},{"text":"100","color":"aqua"},{"text":"%","color":"gray"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run team modify survisland.temp.sidebar.1 suffix [{"text":"Équipe Ijo : ","color":"dark_purple"},{"text":"100","color":"aqua"},{"text":"%","color":"gray"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire de l'équipe : "},{"selector":"@a[team=mBekou,sort=random]"},{"text":" !\n"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire de l'équipe : "},{"selector":"@a[team=mGalia,sort=random]"},{"text":" !\n"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire de l'équipe : "},{"selector":"@a[team=mIjo,sort=random]"},{"text":" !\n"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;16515329]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;15073054]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;7471612]}]}}}}
execute if score #process_end survisland.data matches 1 as @a at @s run function survisland:sounds/toast.challenge_complete
execute if score #process_end survisland.data matches 1 run gamemode survival @a[gamemode=adventure]

execute if score #process_end survisland.data matches 300 run function survisland:modes/brain_rooms/stop

