
## Real :
# Get the distance
execute store result score #x survisland.data run data get entity @s Pos[0]
execute store result score #y survisland.data run data get entity @s Pos[1]
execute store result score #z survisland.data run data get entity @s Pos[2]
scoreboard players operation #x survisland.data -= #resp_x survisland.data
scoreboard players operation #y survisland.data -= #resp_y survisland.data
scoreboard players operation #z survisland.data -= #resp_z survisland.data
scoreboard players operation #x survisland.data *= #x survisland.data
scoreboard players operation #y survisland.data *= #y survisland.data
scoreboard players operation #z survisland.data *= #z survisland.data

# Compare
scoreboard players operation #x survisland.data += #y survisland.data
scoreboard players operation #x survisland.data += #z survisland.data
execute if score #x survisland.data < #min survisland.data run scoreboard players operation #min survisland.data = #x survisland.data

