
#> survisland:modes/pr_stoupy/breakout/begin_level
#
# @within	survisland:modes/pr_stoupy/breakout/start
#			survisland:modes/pr_stoupy/breakout/next_level
#

kill @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
# The level block lets command blocks clone the bricks of the level in during the countdown, it is taken back at the launch
execute if score #pr_breakout_level survisland.data matches 1 at @e[type=minecraft:marker,tag=survisland.pr_breakout.level_block,predicate=survisland:modes/pr_stoupy/breakout/same_arena] run setblock ~ ~ ~ minecraft:iron_block
execute if score #pr_breakout_level survisland.data matches 2 at @e[type=minecraft:marker,tag=survisland.pr_breakout.level_block,predicate=survisland:modes/pr_stoupy/breakout/same_arena] run setblock ~ ~ ~ minecraft:gold_block
execute if score #pr_breakout_level survisland.data matches 3 at @e[type=minecraft:marker,tag=survisland.pr_breakout.level_block,predicate=survisland:modes/pr_stoupy/breakout/same_arena] run setblock ~ ~ ~ minecraft:diamond_block
function survisland:modes/pr_stoupy/breakout/place_bumpers
scoreboard players set #pr_breakout_state survisland.data 1
scoreboard players set #pr_breakout_timer survisland.data 140
data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Niveau ", "color": "#01FE41"}, {"score": {"name": "#pr_breakout_level", "objective": "survisland.data"}, "color": "#01FE41"}, {"text": "/3", "color": "#01FE41"}]

