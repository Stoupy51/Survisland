
#> survisland:modes/pr_stoupy/breakout/place_bumpers
#
# @within	survisland:modes/pr_stoupy/breakout/begin_level
#

# The bumper row is emptied, then each player gets its bumper back, spread evenly along the row
kill @e[type=minecraft:block_display,tag=survisland.pr_breakout.bumper,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
execute store result storage survisland:pr_breakout row.last int 1 run scoreboard players remove #pr_breakout_width survisland.data 1
scoreboard players add #pr_breakout_width survisland.data 1
execute at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] rotated as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] run function survisland:modes/pr_stoupy/breakout/clear_row with storage survisland:pr_breakout row
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] run function survisland:modes/pr_stoupy/breakout/place_bumper

