
scoreboard players set #newPercentage survisland.data 0
execute store result score #newPercentage survisland.data run data get entity @s Pos[0] -100
scoreboard players remove #newPercentage survisland.data 228900

scoreboard players set #divide survisland.data 9700
scoreboard players operation #newPercentage survisland.data *= #100 survisland.data
scoreboard players operation #newPercentage survisland.data /= #divide survisland.data
scoreboard players operation #newPercentage survisland.data *= #-1 survisland.data
execute if score #newPercentage survisland.data matches 100.. run scoreboard players set #newPercentage survisland.data 99
execute if score #newPercentage survisland.data matches ..-1 run scoreboard players set #newPercentage survisland.data 0

scoreboard players operation @s survisland.temp.sidebar = #newPercentage survisland.data
scoreboard players set @s[tag=survisland.winner] survisland.temp.sidebar 100

