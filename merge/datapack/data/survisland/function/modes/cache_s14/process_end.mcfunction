
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve, tous les joueurs ont été trouvés !"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve, temps écoulé !"}]
execute if score #process_end survisland.data matches 1 as @a[team=mPonogoro,tag=survisland.alive] run scoreboard players add #mPonogoro_points survisland.data 20
execute if score #process_end survisland.data matches 1 as @a[team=mKecak,tag=survisland.alive] run scoreboard players add #mKecak_points survisland.data 20
execute if score #process_end survisland.data matches 1 as @a[team=mSinaoh,tag=survisland.alive] run scoreboard players add #mSinaoh_points survisland.data 20
execute if score #process_end survisland.data matches 1 run function survisland:modes/cache_s14/update_sidebar_points

execute if score #process_end survisland.data matches 1 run schedule clear survisland:modes/cache_s14/second
execute if score #process_end survisland.data matches 1 as @a at @s run function survisland:sounds/toast.challenge_complete

execute if score #process_end survisland.data matches 1 run effect clear @a
execute if score #process_end survisland.data matches 1 run effect give @a slow_falling 20 1 true
execute if score #process_end survisland.data matches 1 run effect give @a saturation 20 255 true
execute if score #process_end survisland.data matches 1 run gamemode spectator @a[team=!mKecak,team=!mSinaoh,team=!mPonogoro,gamemode=!creative]

execute if score #process_end survisland.data matches 6000 run function survisland:modes/cache_s14/stop

