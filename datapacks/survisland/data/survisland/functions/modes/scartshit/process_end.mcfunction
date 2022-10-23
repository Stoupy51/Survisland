
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire du joueur : "},{"selector":"@a[tag=survisland.winner]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;852476]}]}}}}
execute if score #process_end survisland.data matches 1 as @a at @s run playsound entity.wither.death ambient @s

#Fin
execute if score #process_end survisland.data matches 1200 run function survisland:modes/scartshit/stop

