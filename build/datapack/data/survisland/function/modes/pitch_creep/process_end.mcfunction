
#> survisland:modes/pitch_creep/process_end
#
# @within	survisland:modes/pitch_creep/tick
#

scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_avec_une_victoire_de_wait_les_deux_derniers_sont_"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_avec_une_victoire_de_lquipe_tuarua"},{"selector":"@a[team=mTuarua,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_avec_une_victoire_de_lquipe_peluang"},{"selector":"@a[team=mPeluang,sort=random]"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;15278847]}]}}}}
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;2666751]}]}}}}

execute if score #process_end survisland.data matches 1 run schedule clear survisland:modes/pitch_creep/second
execute if score #process_end survisland.data matches 1 as @a run attribute @s attack_speed base set 4.0
execute if score #process_end survisland.data matches 1 as @a at @s run playsound entity.wither.death ambient @s

execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] saturation 20 255 true
execute if score #process_end survisland.data matches 1 run clear @a #survisland:layers[minecraft:custom_data={survisland:{pitch_creep:1b}}]
execute if score #process_end survisland.data matches 1 run clear @a arrow 1
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mTuarua]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mPeluang]
execute if score #process_end survisland.data matches 1 run tp @e[type=creeper] 0 -10000 0

execute if score #process_end survisland.data matches 1 run fill -993 59 -2896 -993 59 -2877 air destroy
execute if score #process_end survisland.data matches 1 run fill -991 58 -2873 -995 54 -2873 air replace emerald_block

execute if score #process_end survisland.data matches 1000 run function survisland:modes/pitch_creep/stop

