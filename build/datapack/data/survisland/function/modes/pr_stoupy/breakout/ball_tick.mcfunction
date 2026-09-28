
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

# Sideways bounce: the brick hit is on the side the ball was heading to
scoreboard players operation #pr_breakout_flip survisland.data = #pr_breakout_mu survisland.data
scoreboard players operation #pr_breakout_flip survisland.data *= @s survisland.pr_breakout.mu
execute if score #pr_breakout_flip survisland.data matches ..-1 if score #pr_breakout_axis survisland.data matches 0 if score @s survisland.pr_breakout.mu matches 1.. positioned ~0.5 ~0.2 ~ run function survisland:modes/pr_stoupy/breakout/hit_brick
execute if score #pr_breakout_flip survisland.data matches ..-1 if score #pr_breakout_axis survisland.data matches 0 if score @s survisland.pr_breakout.mu matches ..-1 positioned ~-0.5 ~0.2 ~ run function survisland:modes/pr_stoupy/breakout/hit_brick
execute if score #pr_breakout_flip survisland.data matches ..-1 if score #pr_breakout_axis survisland.data matches 1 if score @s survisland.pr_breakout.mu matches 1.. positioned ~ ~0.2 ~0.5 run function survisland:modes/pr_stoupy/breakout/hit_brick
execute if score #pr_breakout_flip survisland.data matches ..-1 if score #pr_breakout_axis survisland.data matches 1 if score @s survisland.pr_breakout.mu matches ..-1 positioned ~ ~0.2 ~-0.5 run function survisland:modes/pr_stoupy/breakout/hit_brick

# Vertical bounce: a ceiling, or on the way down a bumper or the top of a brick
scoreboard players operation #pr_breakout_flip survisland.data = #pr_breakout_mv survisland.data
scoreboard players operation #pr_breakout_flip survisland.data *= @s survisland.pr_breakout.mv
execute if score #pr_breakout_flip survisland.data matches ..-1 if score @s survisland.pr_breakout.mv matches 1.. positioned ~ ~0.7 ~ run function survisland:modes/pr_stoupy/breakout/hit_brick
execute if score #pr_breakout_flip survisland.data matches ..-1 if score @s survisland.pr_breakout.mv matches ..-1 run function survisland:modes/pr_stoupy/breakout/bounce_below

scoreboard players operation @s survisland.pr_breakout.mu = #pr_breakout_mu survisland.data
scoreboard players operation @s survisland.pr_breakout.mv = #pr_breakout_mv survisland.data

