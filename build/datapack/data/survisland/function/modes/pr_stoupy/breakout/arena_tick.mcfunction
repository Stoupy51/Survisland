
#> survisland:modes/pr_stoupy/breakout/arena_tick
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/tick [ at @s ]
#

# State: 1 countdown, 2 balls in play, 3 level cleared and waiting for next_level, 0 stopped
execute unless score @s survisland.pr_breakout.state matches 1..2 run return 0
function survisland:modes/pr_stoupy/breakout/load_arena
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] unless predicate survisland:riding run function survisland:modes/pr_stoupy/breakout/remount
execute if score #pr_breakout_state survisland.data matches 1 run function survisland:modes/pr_stoupy/breakout/countdown_tick
execute if score #pr_breakout_state survisland.data matches 2 run function survisland:modes/pr_stoupy/breakout/play_tick
execute if score #pr_breakout_state survisland.data matches 1..2 run scoreboard players add #pr_breakout_active survisland.data 1
function survisland:modes/pr_stoupy/breakout/save_arena

