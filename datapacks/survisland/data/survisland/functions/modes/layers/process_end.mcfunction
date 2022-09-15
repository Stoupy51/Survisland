
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 unless score #mAkijan_restants survisland.data matches 0 if score #mHainy_restants survisland.data matches 0 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin du Layers avec une victoire de l'équipe Akijan : "},{"selector":"@a[team=mAkijan,sort=random]"}]
execute if score #process_end survisland.data matches 1 unless score #mHainy_restants survisland.data matches 0 if score #mAkijan_restants survisland.data matches 0 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin du Layers avec une victoire de l'équipe Hainy : "},{"selector":"@a[team=mHainy,sort=random]"}]
execute if score #process_end survisland.data matches 1 unless score #mAkijan_restants survisland.data matches 0 if score #mHainy_restants survisland.data matches 0 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;2651799]}]}}}}
execute if score #process_end survisland.data matches 1 unless score #mHainy_restants survisland.data matches 0 if score #mAkijan_restants survisland.data matches 0 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;3887386]}]}}}}
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mAkijan]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mHainy]
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] slow_falling 20 0 true
execute if score #process_end survisland.data matches 1 run clear @a #survisland:layers
execute if score #process_end survisland.data matches 1 as @a at @s run playsound entity.wither.death ambient @s

execute if score #process_end survisland.data matches 2 run fill -1205 114 -2815 -1241 114 -2753 air
execute if score #process_end survisland.data matches 3 run fill -1205 113 -2815 -1241 113 -2753 air
execute if score #process_end survisland.data matches 4 run fill -1205 112 -2815 -1241 112 -2753 air
execute if score #process_end survisland.data matches 5 run fill -1205 111 -2815 -1241 111 -2753 air
execute if score #process_end survisland.data matches 6 run fill -1205 110 -2815 -1241 110 -2753 air
execute if score #process_end survisland.data matches 7 run fill -1205 109 -2815 -1241 109 -2753 air
execute if score #process_end survisland.data matches 8 run fill -1205 108 -2815 -1241 108 -2753 air
execute if score #process_end survisland.data matches 9 run fill -1205 107 -2815 -1241 107 -2753 air
execute if score #process_end survisland.data matches 10 run fill -1205 106 -2815 -1241 106 -2753 air
execute if score #process_end survisland.data matches 11 run fill -1205 105 -2815 -1241 105 -2753 air
execute if score #process_end survisland.data matches 12 run fill -1205 104 -2815 -1241 104 -2753 air
execute if score #process_end survisland.data matches 13 run fill -1205 103 -2815 -1241 103 -2753 air
execute if score #process_end survisland.data matches 14 run fill -1205 102 -2815 -1241 102 -2753 air
execute if score #process_end survisland.data matches 15 run fill -1205 101 -2815 -1241 101 -2753 air
execute if score #process_end survisland.data matches 16 run fill -1205 100 -2815 -1241 100 -2753 air
execute if score #process_end survisland.data matches 17 run fill -1205 99 -2815 -1241 99 -2753 air
execute if score #process_end survisland.data matches 18 run fill -1205 98 -2815 -1241 98 -2753 air
execute if score #process_end survisland.data matches 19 run fill -1205 97 -2815 -1241 97 -2753 air
execute if score #process_end survisland.data matches 20 run fill -1205 96 -2815 -1241 96 -2753 air
execute if score #process_end survisland.data matches 21 run fill -1205 95 -2815 -1241 95 -2753 air
execute if score #process_end survisland.data matches 22 run fill -1205 94 -2815 -1241 94 -2753 air
execute if score #process_end survisland.data matches 23 run fill -1205 93 -2815 -1241 93 -2753 air
execute if score #process_end survisland.data matches 24 run fill -1205 92 -2815 -1241 92 -2753 air
execute if score #process_end survisland.data matches 25 run fill -1205 91 -2815 -1241 91 -2753 air
execute if score #process_end survisland.data matches 26 run fill -1205 90 -2815 -1241 90 -2753 air
execute if score #process_end survisland.data matches 27 run fill -1205 89 -2815 -1241 89 -2753 air
execute if score #process_end survisland.data matches 28 run fill -1205 88 -2815 -1241 88 -2753 air
execute if score #process_end survisland.data matches 29 run fill -1205 87 -2815 -1241 87 -2753 air
execute if score #process_end survisland.data matches 30 run fill -1205 86 -2815 -1241 86 -2753 air
execute if score #process_end survisland.data matches 31 run fill -1205 85 -2815 -1241 85 -2753 air
execute if score #process_end survisland.data matches 32 run fill -1205 84 -2815 -1241 84 -2753 air
execute if score #process_end survisland.data matches 33 run fill -1205 83 -2815 -1241 83 -2753 air
execute if score #process_end survisland.data matches 34 run fill -1205 82 -2815 -1241 82 -2753 air
execute if score #process_end survisland.data matches 35 run fill -1205 81 -2815 -1241 81 -2753 air
execute if score #process_end survisland.data matches 36 run fill -1205 80 -2815 -1241 80 -2753 air
execute if score #process_end survisland.data matches 37 run fill -1205 79 -2815 -1241 79 -2753 air
execute if score #process_end survisland.data matches 38 run fill -1205 78 -2815 -1241 78 -2753 air
execute if score #process_end survisland.data matches 39 run fill -1205 77 -2815 -1241 77 -2753 air
execute if score #process_end survisland.data matches 40 run fill -1205 76 -2815 -1241 76 -2753 air
execute if score #process_end survisland.data matches 41 run fill -1205 75 -2815 -1241 75 -2753 air
execute if score #process_end survisland.data matches 42 run fill -1205 74 -2815 -1241 74 -2753 air
execute if score #process_end survisland.data matches 43 run fill -1205 73 -2815 -1241 73 -2753 air
execute if score #process_end survisland.data matches 44 run fill -1205 72 -2815 -1241 72 -2753 air
execute if score #process_end survisland.data matches 45 run fill -1205 71 -2815 -1241 71 -2753 air
execute if score #process_end survisland.data matches 46 run fill -1205 70 -2815 -1241 70 -2753 air
execute if score #process_end survisland.data matches 47 run fill -1205 69 -2815 -1241 69 -2753 air
execute if score #process_end survisland.data matches 48 run fill -1205 68 -2815 -1241 68 -2753 air
execute if score #process_end survisland.data matches 49 run fill -1205 67 -2815 -1241 67 -2753 air
execute if score #process_end survisland.data matches 50 run fill -1205 66 -2815 -1241 66 -2753 air
execute if score #process_end survisland.data matches 51 run fill -1205 65 -2815 -1241 65 -2753 air
execute if score #process_end survisland.data matches 52 run fill -1205 64 -2815 -1241 64 -2753 air
execute if score #process_end survisland.data matches 53 run fill -1205 63 -2815 -1241 63 -2753 air
execute if score #process_end survisland.data matches 54 run fill -1205 62 -2815 -1241 62 -2753 air
execute if score #process_end survisland.data matches 55 run fill -1205 61 -2815 -1241 61 -2753 air
execute if score #process_end survisland.data matches 56 run fill -1205 60 -2815 -1241 60 -2753 air
execute if score #process_end survisland.data matches 57 run fill -1205 59 -2815 -1241 59 -2753 air
execute if score #process_end survisland.data matches 58 run fill -1205 58 -2815 -1241 58 -2753 air
execute if score #process_end survisland.data matches 59 run fill -1205 57 -2815 -1241 57 -2753 air
execute if score #process_end survisland.data matches 60 run fill -1205 56 -2815 -1241 56 -2753 air
execute if score #process_end survisland.data matches 61 run fill -1205 55 -2815 -1241 55 -2753 air
execute if score #process_end survisland.data matches 62 run fill -1205 54 -2815 -1241 54 -2753 air
execute if score #process_end survisland.data matches 63 run fill -1205 53 -2815 -1241 53 -2753 air
execute if score #process_end survisland.data matches 64 run fill -1205 52 -2815 -1241 52 -2753 air
execute if score #process_end survisland.data matches 65 run fill -1205 51 -2815 -1241 51 -2753 air

execute if score #process_end survisland.data matches 100 run function survisland:modes/layers/stop

