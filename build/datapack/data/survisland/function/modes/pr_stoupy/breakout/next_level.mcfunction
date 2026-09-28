
#> survisland:modes/pr_stoupy/breakout/next_level
#
# @executed	as @n[type=minecraft:marker,tag=survisland.pr_breakout.corner]
#
# @within	survisland:modes/pr_stoupy/breakout/here/next_level [ as @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] ]
#

# @s is the corner of the field
function survisland:modes/pr_stoupy/breakout/load_arena
scoreboard players add #pr_breakout_level survisland.data 1
function survisland:modes/pr_stoupy/breakout/begin_level
function survisland:modes/pr_stoupy/breakout/save_arena

