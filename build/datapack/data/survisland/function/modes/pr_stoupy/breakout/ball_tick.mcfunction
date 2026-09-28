
#> survisland:modes/pr_stoupy/breakout/ball_tick
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/play_tick [ at @s ]
#

# A death or a cleared level earlier in this tick already removed every ball
execute unless score #pr_breakout_state survisland.data matches 2 run return 0

# One entity read per tick, every value then comes from the storage
data modify storage survisland:pr_breakout ball set from entity @s
execute if score #pr_breakout_axis survisland.data matches 0 store result score #pr_breakout_u survisland.data run data get storage survisland:pr_breakout ball.Pos[0] 1000
execute if score #pr_breakout_axis survisland.data matches 1 store result score #pr_breakout_u survisland.data run data get storage survisland:pr_breakout ball.Pos[2] 1000
execute store result score #pr_breakout_v survisland.data run data get storage survisland:pr_breakout ball.Pos[1] 1000
execute if score #pr_breakout_axis survisland.data matches 0 store result score #pr_breakout_mu survisland.data run data get storage survisland:pr_breakout ball.Motion[0] 1000
execute if score #pr_breakout_axis survisland.data matches 1 store result score #pr_breakout_mu survisland.data run data get storage survisland:pr_breakout ball.Motion[2] 1000
execute store result score #pr_breakout_mv survisland.data run data get storage survisland:pr_breakout ball.Motion[1] 1000

execute if score #pr_breakout_v survisland.data < #pr_breakout_death_v survisland.data run return run function survisland:modes/pr_stoupy/breakout/death

# Probes are made facing the heading of the ball along the field, so ^ ^ ^1 is one block ahead of it
execute if score #pr_breakout_axis survisland.data matches 0 if score @s survisland.pr_breakout.mu matches 0.. rotated -90 0 run function survisland:modes/pr_stoupy/breakout/bounces
execute if score #pr_breakout_axis survisland.data matches 0 if score @s survisland.pr_breakout.mu matches ..-1 rotated 90 0 run function survisland:modes/pr_stoupy/breakout/bounces
execute if score #pr_breakout_axis survisland.data matches 1 if score @s survisland.pr_breakout.mu matches 0.. rotated 0 0 run function survisland:modes/pr_stoupy/breakout/bounces
execute if score #pr_breakout_axis survisland.data matches 1 if score @s survisland.pr_breakout.mu matches ..-1 rotated 180 0 run function survisland:modes/pr_stoupy/breakout/bounces

scoreboard players operation @s survisland.pr_breakout.mu = #pr_breakout_mu survisland.data
scoreboard players operation @s survisland.pr_breakout.mv = #pr_breakout_mv survisland.data

