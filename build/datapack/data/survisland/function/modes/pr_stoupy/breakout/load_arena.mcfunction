
#> survisland:modes/pr_stoupy/breakout/load_arena
#
# @executed	as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,distance=..16]
#
# @within	survisland:modes/pr_stoupy/breakout/forget_arena
#			survisland:modes/pr_stoupy/breakout/arena_tick
#			survisland:modes/pr_stoupy/breakout/start [ as @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] ]
#			survisland:modes/pr_stoupy/breakout/next_level
#			survisland:modes/pr_stoupy/breakout/stop_corner
#

# @s is a corner
scoreboard players operation #pr_breakout_arena survisland.data = @s survisland.pr_breakout.arena
scoreboard players operation #pr_breakout_state survisland.data = @s survisland.pr_breakout.state
scoreboard players operation #pr_breakout_timer survisland.data = @s survisland.pr_breakout.timer
scoreboard players operation #pr_breakout_level survisland.data = @s survisland.pr_breakout.level
scoreboard players operation #pr_breakout_clock survisland.data = @s survisland.pr_breakout.clock
scoreboard players operation #pr_breakout_axis survisland.data = @s survisland.pr_breakout.axis
scoreboard players operation #pr_breakout_width survisland.data = @s survisland.pr_breakout.width
scoreboard players operation #pr_breakout_height survisland.data = @s survisland.pr_breakout.height
scoreboard players operation #pr_breakout_invert survisland.data = @s survisland.pr_breakout.invert
scoreboard players operation #pr_breakout_death_v survisland.data = @s survisland.pr_breakout.death_v
scoreboard players operation #pr_breakout_bumper_top survisland.data = @s survisland.pr_breakout.bumper_top
scoreboard players operation #pr_breakout_remaining survisland.data = @s survisland.pr_breakout.remaining

