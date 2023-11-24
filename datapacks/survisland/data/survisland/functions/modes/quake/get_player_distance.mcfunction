
# At every player that is not dead, calculate the minimal distance
scoreboard players set #min survisland.data 1000000000
execute store result score #resp_x survisland.data run data get entity @s Pos[0]
execute store result score #resp_y survisland.data run data get entity @s Pos[1]
execute store result score #resp_z survisland.data run data get entity @s Pos[2]
execute as @a[team=mMerge,tag=!iris.target] run function survisland:modes/quake/compare_distance

# Remember the minimal distance
scoreboard players operation @s survisland.data = #min survisland.data

