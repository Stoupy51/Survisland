
#> survisland:modes/minecart_lever/process_end
#
# @within	survisland:modes/minecart_lever/tick
#

scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire du grand joueur : "},{"selector":"@a[scores={survisland.temp.sidebar=23}]"}]
execute if score #process_end survisland.data matches 1 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;3789123]}]}}}}
execute if score #process_end survisland.data matches 1 run gamemode survival @a[gamemode=adventure]
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] jump_boost 10 20 true
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] slow_falling 20 0 true
execute if score #process_end survisland.data matches 1 as @a at @s run playsound ui.toast.challenge_complete ambient @s

#Fin
execute if score #process_end survisland.data matches 600 run function survisland:modes/minecart_lever/stop

