
#> survisland:modes/pitch_creep/creeper
#
# @executed	as @e[type=creeper,tag=survisland.new]
#
# @within	survisland:modes/pitch_creep/second [ as @e[type=creeper,tag=survisland.new] ]
#

tag @s remove survisland.new
execute store result score #random survisland.data run data get entity @s UUID[0]
scoreboard players operation #random survisland.data %= #19 survisland.data

data modify entity @s Pos set value [-992.5d, 58.0d, -2896.5d]
execute store result score #posZ survisland.data run data get entity @s Pos[2]
scoreboard players operation #posZ survisland.data += #random survisland.data
execute store result entity @s Pos[2] double 1 run scoreboard players get #posZ survisland.data

