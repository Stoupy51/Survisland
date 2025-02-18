
# If time is beaten, stop race (2280 ticks = 1m54s to beat)
execute if score @s survisland.temp.race_start matches ..2280 if block ~ ~ ~ minecraft:redstone_lamp run function survisland:modes/shiren_trials/race/win

# If not beaten, print message
execute if score @s survisland.temp.race_start matches 2281.. run scoreboard players operation #total_seconds survisland.temp.race_start = @s survisland.temp.race_start
execute if score @s survisland.temp.race_start matches 2281.. run scoreboard players operation #total_seconds survisland.temp.race_start /= #20 survisland.data
execute if score @s survisland.temp.race_start matches 2281.. run scoreboard players operation #minutes survisland.temp.race_start = #total_seconds survisland.temp.race_start
execute if score @s survisland.temp.race_start matches 2281.. run scoreboard players operation #seconds survisland.temp.race_start = #total_seconds survisland.temp.race_start
execute if score @s survisland.temp.race_start matches 2281.. run scoreboard players operation #minutes survisland.temp.race_start /= #60 survisland.data
execute if score @s survisland.temp.race_start matches 2281.. run scoreboard players operation #seconds survisland.temp.race_start %= #60 survisland.data
execute if score @s survisland.temp.race_start matches 2281.. run tellraw @s ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Temps effectué (pas assez rapide) : "},{"score":{"name":"#minutes","objective":"survisland.temp.race_start"},"color":"red"},{"text":"m","color":"red"},{"score":{"name":"#seconds","objective":"survisland.temp.race_start"},"color":"red"},{"text":"s","color":"red"}]

# Leave trial
ride @s dismount

