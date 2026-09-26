
#> survisland:modes/pr_stoupy/breakout/victory
#
# @executed	positioned ~0.5 ~0.2 ~
#
# @within	survisland:modes/pr_stoupy/breakout/level_cleared
#

data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value {"text": "Bravo !", "color": "#01FE41"}
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout=1},limit=1] at @s run function survisland:modes/pr_stoupy/give_star {trial:"Le casse-briques"}
function survisland:modes/pr_stoupy/breakout/stop_arena

