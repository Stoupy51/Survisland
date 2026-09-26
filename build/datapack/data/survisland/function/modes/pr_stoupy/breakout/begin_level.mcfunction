
#> survisland:modes/pr_stoupy/breakout/begin_level
#
# @within	survisland:modes/pr_stoupy/breakout/start
#			survisland:modes/pr_stoupy/breakout/next_level
#

kill @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
function survisland:modes/pr_stoupy/breakout/count_bricks
function survisland:modes/pr_stoupy/breakout/place_bumpers
scoreboard players set #pr_breakout_state survisland.data 1
scoreboard players set #pr_breakout_timer survisland.data 140
data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Niveau ", "color": "#01FE41"}, {"score": {"name": "#pr_breakout_level", "objective": "survisland.data"}, "color": "#01FE41"}, {"text": "/3", "color": "#01FE41"}]

