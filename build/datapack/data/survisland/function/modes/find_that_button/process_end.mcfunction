
#> survisland:modes/find_that_button/process_end
#
# @within	survisland:modes/find_that_button/tick
#

scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_de_find_the_button_avec_une_victoire_de_lquipe_ke"},{"selector":"@a[team=mKembali,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_de_find_the_button_avec_une_victoire_de_lquipe_tu"},{"selector":"@a[team=mTuarua,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_de_find_the_button_avec_une_victoire_de_lquipe_pe"},{"selector":"@a[team=mPeluang,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 at @a[gamemode=!spectator] run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;14602026]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 at @a[gamemode=!spectator] run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;12801229]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 at @a[gamemode=!spectator] run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;6719955]}]}}}}
execute if score #process_end survisland.data matches 1 run gamemode survival @a[gamemode=adventure]
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] jump_boost 10 20 true
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] slow_falling 20 0 true
execute if score #process_end survisland.data matches 1 as @a at @s run playsound entity.wither.death ambient @s

#Fin
execute if score #process_end survisland.data matches 1000 run function survisland:modes/find_that_button/stop

