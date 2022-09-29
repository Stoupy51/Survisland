
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire de....., wait....., les deux derniers sont mort en même temps ! Bon bah on conclut sur le dernier message de mort !"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire de l'équipe Tuarua : "},{"selector":"@a[team=mTuarua,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire de l'équipe Peluang : "},{"selector":"@a[team=mPeluang,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;15278847]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;2666751]}]}}}}

execute if score #process_end survisland.data matches 1 run schedule clear survisland:modes/pitch_creep/second
execute if score #process_end survisland.data matches 1 as @a run attribute @s generic.attack_speed base set 4.0
execute if score #process_end survisland.data matches 1 as @a at @s run playsound entity.wither.death ambient @s

execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] saturation 20 255 true
execute if score #process_end survisland.data matches 1 run clear @a #survisland:layers{survisland:{pitch_creep:1b}}
execute if score #process_end survisland.data matches 1 run clear @a arrow 1
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mTuarua]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mPeluang]
execute if score #process_end survisland.data matches 1 run tp @e[type=creeper] 0 -10000 0

execute if score #process_end survisland.data matches 1 run fill -993 59 -2896 -993 59 -2877 air destroy
execute if score #process_end survisland.data matches 1 run fill -991 58 -2873 -995 54 -2873 air replace emerald_block

execute if score #process_end survisland.data matches 1000 run function survisland:modes/pitch_creep/stop

