
#> survisland:modes/snk_lab/process_end
#
# @within	survisland:modes/snk_lab/tick
#

scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run team modify survisland.temp.sidebar.2 suffix [{"text":"kijan : ","color":"dark_aqua"},{"text":"666","color":"yellow"},{"text":"%","color":"gray"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run team modify survisland.temp.sidebar.1 suffix [{"text":"ainy : ","color":"green"},{"text":"666","color":"yellow"},{"text":"%","color":"gray"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire de l'équipe Akijan : "},{"selector":"@a[team=mAkijan,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire de l'équipe Hainy : "},{"selector":"@a[team=mHainy,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 at @a[gamemode=!spectator] run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;696006]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 at @a[gamemode=!spectator] run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;3789123]}]}}}}
execute if score #process_end survisland.data matches 1 run gamemode survival @a[gamemode=adventure]
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] jump_boost 10 20 true
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] slow_falling 20 0 true
execute if score #process_end survisland.data matches 1 as @a at @s run playsound entity.wither.death ambient @s

execute if score #detect_end survisland.data matches 0 if block -1283 68 -2822 redstone_lamp[lit=true] if block -1283 68 -2819 redstone_lamp[lit=true] run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 0 if block -1283 68 -2780 redstone_lamp[lit=true] if block -1283 68 -2777 redstone_lamp[lit=true] run scoreboard players set #detect_end survisland.data 2

#Fin
execute if score #process_end survisland.data matches 1000 run function survisland:modes/snk_lab/stop

