
##Ajout des points selon la couleur et le type :
scoreboard players set #add survisland.data 3
execute if entity @s[type=pig] run scoreboard players set #add survisland.data 1

scoreboard players set #success survisland.data 0
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ red_concrete run tag @a[scores={survisland.temp.color=1}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ orange_concrete run tag @a[scores={survisland.temp.color=2}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ yellow_concrete run tag @a[scores={survisland.temp.color=3}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ lime_concrete run tag @a[scores={survisland.temp.color=4}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ green_concrete run tag @a[scores={survisland.temp.color=5}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ light_blue_concrete run tag @a[scores={survisland.temp.color=6}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ cyan_concrete run tag @a[scores={survisland.temp.color=7}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ blue_concrete run tag @a[scores={survisland.temp.color=8}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ purple_concrete run tag @a[scores={survisland.temp.color=9}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ magenta_concrete run tag @a[scores={survisland.temp.color=10}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ pink_concrete run tag @a[scores={survisland.temp.color=11}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ brown_concrete run tag @a[scores={survisland.temp.color=12}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ gray_concrete run tag @a[scores={survisland.temp.color=13}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ light_gray_concrete run tag @a[scores={survisland.temp.color=14}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ white_concrete run tag @a[scores={survisland.temp.color=15}] add survisland.give_points
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ black_concrete run tag @a[scores={survisland.temp.color=16}] add survisland.give_points

scoreboard players operation @a[tag=survisland.give_points] survisland.temp.sidebar += #add survisland.data
execute as @a[tag=survisland.give_points] at @s run playsound entity.player.levelup ambient @s
tag @a[tag=survisland.give_points] remove survisland.give_points

tp @s 0 -10000 0
kill @s
