
#> survisland:modes/pr_stoupy/breakout/forget_arena
#
# @executed	as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,distance=..16]
#
# @within	survisland:modes/pr_stoupy/breakout/here/setup [ as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,distance=..16] ]
#

# @s is the corner of a field set up again: its game, its screen and its bumpers go away with it
function survisland:modes/pr_stoupy/breakout/load_arena
function survisland:modes/pr_stoupy/breakout/stop_arena
kill @e[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
kill @e[type=minecraft:marker,tag=survisland.pr_breakout.level_block,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
kill @s

