
#> survisland:modes/pr_stoupy/breakout/save_arena
#
# @executed	align xyz & positioned ~0.5 ~ ~0.5
#
# @within	survisland:modes/pr_stoupy/breakout/setup_corner
#			survisland:modes/pr_stoupy/breakout/arena_tick
#			survisland:modes/pr_stoupy/breakout/start [ as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] ]
#			survisland:modes/pr_stoupy/breakout/next_level
#			survisland:modes/pr_stoupy/breakout/stop_corner
#

# @s is a corner
scoreboard players operation @s survisland.pr_breakout.arena = #pr_breakout_arena survisland.data
scoreboard players operation @s survisland.pr_breakout.state = #pr_breakout_state survisland.data
scoreboard players operation @s survisland.pr_breakout.timer = #pr_breakout_timer survisland.data
scoreboard players operation @s survisland.pr_breakout.level = #pr_breakout_level survisland.data
scoreboard players operation @s survisland.pr_breakout.clock = #pr_breakout_clock survisland.data
scoreboard players operation @s survisland.pr_breakout.axis = #pr_breakout_axis survisland.data
scoreboard players operation @s survisland.pr_breakout.width = #pr_breakout_width survisland.data
scoreboard players operation @s survisland.pr_breakout.height = #pr_breakout_height survisland.data
scoreboard players operation @s survisland.pr_breakout.invert = #pr_breakout_invert survisland.data
scoreboard players operation @s survisland.pr_breakout.death_v = #pr_breakout_death_v survisland.data
scoreboard players operation @s survisland.pr_breakout.bumper_top = #pr_breakout_bumper_top survisland.data
scoreboard players operation @s survisland.pr_breakout.remaining = #pr_breakout_remaining survisland.data
scoreboard players operation @s survisland.pr_breakout.solo = #pr_breakout_solo survisland.data
scoreboard players operation @s survisland.pr_breakout.broken = #pr_breakout_broken survisland.data
scoreboard players operation @s survisland.pr_breakout.bonus = #pr_breakout_bonus survisland.data

