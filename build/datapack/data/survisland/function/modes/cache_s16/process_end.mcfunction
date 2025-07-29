
#> survisland:modes/cache_s16/process_end
#
# @within	survisland:modes/cache_s16/tick
#

scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_tous_les_joueurs_ont_t_trouvs"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_temps_coul"}]
execute if score #process_end survisland.data matches 1 as @a[team=mLiwai,tag=survisland.alive] run scoreboard players add #mLiwai_points survisland.data 20
execute if score #process_end survisland.data matches 1 as @a[team=mMoemoea,tag=survisland.alive] run scoreboard players add #mMoemoea_points survisland.data 20
execute if score #process_end survisland.data matches 1 run function survisland:modes/cache_s16/update_sidebar_points
execute if score #process_end survisland.data matches 1 if score #mLiwai_points survisland.data = #mMoemoea_points survisland.data run scoreboard players set #detect_end survisland.data 5
execute if score #process_end survisland.data matches 1 if score #mLiwai_points survisland.data > #mMoemoea_points survisland.data run scoreboard players set #detect_end survisland.data 4
execute if score #process_end survisland.data matches 1 if score #mLiwai_points survisland.data < #mMoemoea_points survisland.data run scoreboard players set #detect_end survisland.data 3
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 5 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.avec_une_victoire_de_wait_galit_des_points"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 4 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.avec_une_victoire_de_lquipe_sambor"},{"selector":"@a[team=mLiwai,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.avec_une_victoire_de_lquipe_kanawa"},{"selector":"@a[team=mMoemoea,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 4 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;16777215]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;0]}]}}}}

execute if score #process_end survisland.data matches 1 run schedule clear survisland:modes/cache_s16/second
execute if score #process_end survisland.data matches 1 as @a at @s run function survisland:sounds/toast.challenge_complete

execute if score #process_end survisland.data matches 1 run effect clear @a
execute if score #process_end survisland.data matches 1 run effect give @a slow_falling 20 1 true
execute if score #process_end survisland.data matches 1 run effect give @a saturation 20 255 true
execute if score #process_end survisland.data matches 1 run gamemode spectator @a[team=!mLiwai,team=!mMoemoea,gamemode=!creative]
execute if score #process_end survisland.data matches 1 run gamemode adventure @a[team=mLiwai]
execute if score #process_end survisland.data matches 1 run gamemode adventure @a[team=mMoemoea]

execute if score #process_end survisland.data matches 6000 run function survisland:modes/cache_s16/stop

