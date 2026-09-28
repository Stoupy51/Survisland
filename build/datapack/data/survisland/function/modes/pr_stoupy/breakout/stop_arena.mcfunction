
#> survisland:modes/pr_stoupy/breakout/stop_arena
#
# @executed	as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,distance=..16]
#
# @within	survisland:modes/pr_stoupy/breakout/forget_arena
#			survisland:modes/pr_stoupy/breakout/victory
#			survisland:modes/pr_stoupy/breakout/stop_corner
#

# The arena loaded in the fake players goes back to rest
kill @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
execute as @e[type=minecraft:block_display,tag=survisland.pr_breakout.bumper,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run fill ^ ^ ^ ^ ^ ^1 minecraft:air replace minecraft:barrier
kill @e[type=minecraft:block_display,tag=survisland.pr_breakout.bumper,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] run function survisland:modes/pr_stoupy/breakout/release_player
scoreboard players set #pr_breakout_state survisland.data 0

