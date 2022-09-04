
scoreboard players set #random survisland.data 0
execute store result score #random survisland.data run data get entity @s UUID[0]
scoreboard players operation #random survisland.data %= #list_length survisland.data
kill @s

