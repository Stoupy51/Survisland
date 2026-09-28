
#> survisland:modes/pr_stoupy/breakout/play_tick
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/arena_tick
#

# Run as and at the corner of the arena, whose state is loaded in the fake players
execute as @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run function survisland:modes/pr_stoupy/breakout/ball_tick

scoreboard players add #pr_breakout_clock survisland.data 1
scoreboard players operation #pr_breakout_step survisland.data = #pr_breakout_clock survisland.data
scoreboard players operation #pr_breakout_step survisland.data %= #2 survisland.data
execute if score #pr_breakout_step survisland.data matches 0 as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] run function survisland:modes/pr_stoupy/breakout/steer

