
#> survisland:modes/pr_stoupy/breakout/next_level
#
# @executed	as @n[type=minecraft:marker,tag=survisland.pr_breakout.corner]
#
# @within	survisland:modes/pr_stoupy/breakout/here/next_level [ as @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] ]
#

# @s is the corner of the field
function survisland:modes/pr_stoupy/breakout/load_arena
scoreboard players add #pr_breakout_level survisland.data 1
title @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] times 10 40 10
title @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] subtitle [{"text": "Prochain niveau : ", "color": "gray"}, {"score": {"name": "#pr_breakout_level", "objective": "survisland.data"}, "color": "aqua"}, {"text": "/3", "color": "aqua"}]
title @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] title {"text": ""}
function survisland:modes/pr_stoupy/breakout/begin_level
function survisland:modes/pr_stoupy/breakout/save_arena

