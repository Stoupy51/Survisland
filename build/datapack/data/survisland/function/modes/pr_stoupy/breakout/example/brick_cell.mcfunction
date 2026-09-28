
#> survisland:modes/pr_stoupy/breakout/example/brick_cell
#
# @executed	at @s & rotated as @s
#
# @within	survisland:modes/pr_stoupy/breakout/example/brick_row
#			survisland:modes/pr_stoupy/breakout/example/brick_cell [ positioned ^ ^ ^1 ]
#

scoreboard players operation #pr_breakout_pick survisland.data = #pr_breakout_cell survisland.data
scoreboard players operation #pr_breakout_pick survisland.data += #pr_breakout_row survisland.data
scoreboard players operation #pr_breakout_pick survisland.data %= #4 survisland.data
execute if score #pr_breakout_pick survisland.data matches 0 run setblock ~ ~ ~ minecraft:red_concrete
execute if score #pr_breakout_pick survisland.data matches 1 run setblock ~ ~ ~ minecraft:light_blue_concrete
execute if score #pr_breakout_pick survisland.data matches 2 run setblock ~ ~ ~ minecraft:lime_concrete
execute if score #pr_breakout_pick survisland.data matches 3 run setblock ~ ~ ~ minecraft:yellow_concrete
scoreboard players add #pr_breakout_cell survisland.data 1
execute if score #pr_breakout_cell survisland.data < #pr_breakout_width survisland.data positioned ^ ^ ^1 run function survisland:modes/pr_stoupy/breakout/example/brick_cell

