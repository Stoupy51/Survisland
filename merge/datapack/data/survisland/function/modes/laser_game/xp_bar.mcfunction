
scoreboard players add @s survisland.temp.cooldown 0
scoreboard players add @s survisland.temp.dead_cooldown 0
scoreboard players add @s[scores={survisland.temp.cooldown=..-1}] survisland.temp.cooldown 1
scoreboard players add @s[scores={survisland.temp.dead_cooldown=..-1}] survisland.temp.dead_cooldown 1
tag @s[tag=global.ignore,scores={survisland.temp.dead_cooldown=0}] remove global.ignore

scoreboard players set #is_alive survisland.data 0
execute if score @s survisland.temp.dead_cooldown matches 0 run scoreboard players set #is_alive survisland.data 1

## XP from 0 to 1000 points
# points > 0 && points < 1000
## When the player is alive: survisland.temp.cooldown (Shoot cooldown)
# -20 ticks = 100%
# 0 ticks = 0%
execute if score #is_alive survisland.data matches 1 run scoreboard players operation #temp survisland.data = @s survisland.temp.cooldown
execute if score #is_alive survisland.data matches 1 run scoreboard players operation #temp survisland.data *= #-1 survisland.data
execute if score #is_alive survisland.data matches 1 run scoreboard players operation #temp survisland.data *= #50 survisland.data
execute if score #is_alive survisland.data matches 1 if entity @s[tag=survisland.bonus.fast] run scoreboard players operation #temp survisland.data *= #5 survisland.data
execute if score #is_alive survisland.data matches 1 run scoreboard players set #points survisland.data 1000
execute if score #is_alive survisland.data matches 1 run scoreboard players operation #points survisland.data -= #temp survisland.data

## When the player is dead: survisland.temp.dead_cooldown (Disabled cooldown)
# -100 ticks = 100%
# 0 ticks = 0%
execute if score #is_alive survisland.data matches 0 run scoreboard players operation #points survisland.data = @s survisland.temp.dead_cooldown
execute if score #is_alive survisland.data matches 0 run scoreboard players operation #points survisland.data *= #-10 survisland.data

# Apply
function survisland:utils/xp_bar_at_s

