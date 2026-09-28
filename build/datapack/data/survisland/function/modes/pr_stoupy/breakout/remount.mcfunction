
#> survisland:modes/pr_stoupy/breakout/remount
#
# @executed	as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
#
# @within	survisland:modes/pr_stoupy/breakout/arena_tick [ as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] ]
#

# Sneaking gets a player off its seat, it is put back on right away
scoreboard players operation #pr_breakout_slot survisland.data = @s survisland.pr_breakout
ride @s mount @e[type=minecraft:item_display,tag=survisland.pr_breakout.seat,predicate=survisland:modes/pr_stoupy/breakout/same_slot,limit=1]

