
#> survisland:modes/pr_stoupy/breakout/bounces
#
# @executed	rotated -90 0
#
# @within	survisland:modes/pr_stoupy/breakout/ball_tick [ rotated -90 0 ]
#			survisland:modes/pr_stoupy/breakout/ball_tick [ rotated 90 0 ]
#			survisland:modes/pr_stoupy/breakout/ball_tick [ rotated 0 0 ]
#			survisland:modes/pr_stoupy/breakout/ball_tick [ rotated 180 0 ]
#

# Sideways bounce: the block hit is ahead of the ball
scoreboard players operation #pr_breakout_flip survisland.data = #pr_breakout_mu survisland.data
scoreboard players operation #pr_breakout_flip survisland.data *= @s survisland.pr_breakout.mu
execute if score #pr_breakout_flip survisland.data matches ..-1 run function survisland:modes/pr_stoupy/breakout/side_bounce

# Vertical bounce: a ceiling, or on the way down a bumper or the top of a brick
scoreboard players operation #pr_breakout_flip survisland.data = #pr_breakout_mv survisland.data
scoreboard players operation #pr_breakout_flip survisland.data *= @s survisland.pr_breakout.mv
execute if score #pr_breakout_flip survisland.data matches ..-1 if score @s survisland.pr_breakout.mv matches 1.. positioned ~ ~0.7 ~ run function survisland:modes/pr_stoupy/breakout/vertical_bounce
execute if score #pr_breakout_flip survisland.data matches ..-1 if score @s survisland.pr_breakout.mv matches ..-1 run function survisland:modes/pr_stoupy/breakout/bounce_below

