
# State
scoreboard players set #state survisland.data 0
execute if data storage survisland:main relative_pos run scoreboard players set #state survisland.data 1

# Second position
execute if score #state survisland.data matches 1 store result score #origin_x survisland.data run data get storage survisland:main relative_pos[0]
execute if score #state survisland.data matches 1 store result score #origin_y survisland.data run data get storage survisland:main relative_pos[1]
execute if score #state survisland.data matches 1 store result score #origin_z survisland.data run data get storage survisland:main relative_pos[2]
execute if score #state survisland.data matches 1 store result score #dest_x survisland.data run data get entity @s Pos[0]
execute if score #state survisland.data matches 1 store result score #dest_y survisland.data run data get entity @s Pos[1]
execute if score #state survisland.data matches 1 store result score #dest_z survisland.data run data get entity @s Pos[2]
execute if score #state survisland.data matches 1 run scoreboard players operation #dest_x survisland.data -= #origin_x survisland.data
execute if score #state survisland.data matches 1 run scoreboard players operation #dest_y survisland.data -= #origin_y survisland.data
execute if score #state survisland.data matches 1 run scoreboard players operation #dest_z survisland.data -= #origin_z survisland.data
execute if score #state survisland.data matches 1 run data modify storage survisland:main positioned set value {x:0,y:0,z:0}
execute if score #state survisland.data matches 1 store result storage survisland:main positioned.x int 1 run data get entity @s Pos[0]
execute if score #state survisland.data matches 1 store result storage survisland:main positioned.y int 1 run data get entity @s Pos[1]
execute if score #state survisland.data matches 1 store result storage survisland:main positioned.z int 1 run data get entity @s Pos[2]
execute if score #state survisland.data matches 1 run function survisland:utils/print_relative with storage survisland:main positioned
execute if score #state survisland.data matches 1 run data remove storage survisland:main positioned

# First position
data remove storage survisland:main relative_pos
execute if score #state survisland.data matches 0 run data modify storage survisland:main relative_pos set from entity @s Pos
execute if score #state survisland.data matches 0 run tellraw @s {"text":"Première position enregistrée.","color":"yellow"}

