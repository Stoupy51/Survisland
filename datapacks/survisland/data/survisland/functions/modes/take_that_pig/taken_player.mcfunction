
##Ajout des points selon la couleur et le type :
scoreboard players set #add survisland.data 10

scoreboard players set #success survisland.data 0
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ red_concrete run scoreboard players operation @a[scores={survisland.temp.color=1}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ orange_concrete run scoreboard players operation @a[scores={survisland.temp.color=2}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ yellow_concrete run scoreboard players operation @a[scores={survisland.temp.color=3}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ lime_concrete run scoreboard players operation @a[scores={survisland.temp.color=4}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ green_concrete run scoreboard players operation @a[scores={survisland.temp.color=5}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ light_blue_concrete run scoreboard players operation @a[scores={survisland.temp.color=6}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ cyan_concrete run scoreboard players operation @a[scores={survisland.temp.color=7}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ blue_concrete run scoreboard players operation @a[scores={survisland.temp.color=8}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ purple_concrete run scoreboard players operation @a[scores={survisland.temp.color=9}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ magenta_concrete run scoreboard players operation @a[scores={survisland.temp.color=10}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ pink_concrete run scoreboard players operation @a[scores={survisland.temp.color=11}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ brown_concrete run scoreboard players operation @a[scores={survisland.temp.color=12}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ gray_concrete run scoreboard players operation @a[scores={survisland.temp.color=13}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ light_gray_concrete run scoreboard players operation @a[scores={survisland.temp.color=14}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ white_concrete run scoreboard players operation @a[scores={survisland.temp.color=15}] survisland.temp.sidebar += #add survisland.data
execute if score #success survisland.data matches 0 store success score #success survisland.data if block ~ ~-1 ~ black_concrete run scoreboard players operation @a[scores={survisland.temp.color=16}] survisland.temp.sidebar += #add survisland.data

gamemode spectator @s
tag @s remove survisland.to_take_spec

