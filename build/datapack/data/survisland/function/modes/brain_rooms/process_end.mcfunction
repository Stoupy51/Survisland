
#> survisland:modes/brain_rooms/process_end
#
# @within	survisland:modes/brain_rooms/tick
#

scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run team modify survisland.temp.sidebar.3 suffix [{"translate": "survisland.quipe_bekou","color":"red"},{"translate": "survisland.100","color":"aqua"},{"text":"%","color":"gray"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run team modify survisland.temp.sidebar.2 suffix [{"translate": "survisland.quipe_galia","color":"yellow"},{"translate": "survisland.100","color":"aqua"},{"text":"%","color":"gray"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run team modify survisland.temp.sidebar.1 suffix [{"translate": "survisland.quipe_ijo","color":"dark_purple"},{"translate": "survisland.100","color":"aqua"},{"text":"%","color":"gray"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_avec_une_victoire_de_lquipe"},{"selector":"@a[team=mBekou,sort=random]"},{"text":" !\n"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_avec_une_victoire_de_lquipe"},{"selector":"@a[team=mGalia,sort=random]"},{"text":" !\n"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_avec_une_victoire_de_lquipe"},{"selector":"@a[team=mIjo,sort=random]"},{"text":" !\n"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;16515329]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;15073054]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;7471612]}]}}}}
execute if score #process_end survisland.data matches 1 as @a at @s run function survisland:sounds/toast.challenge_complete

execute if score #process_end survisland.data matches 300 run function survisland:modes/brain_rooms/stop

