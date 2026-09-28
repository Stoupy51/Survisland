
#> survisland:modes/pr_stoupy/breakout/bonus/multiply_ball
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/bonus/multiball [ at @s ]
#

# @s is a ball in play, its copies share its player, its color and its speed
scoreboard players operation #pr_breakout_slot survisland.data = @s survisland.pr_breakout
scoreboard players operation #pr_breakout_color survisland.data = @s survisland.pr_breakout.color
scoreboard players operation #pr_breakout_speed survisland.data = @s survisland.pr_breakout.speed
execute if score #pr_breakout_balls survisland.data matches ..39 run function survisland:modes/pr_stoupy/breakout/bonus/clone_ball
execute if score #pr_breakout_balls survisland.data matches ..39 run function survisland:modes/pr_stoupy/breakout/bonus/clone_ball
execute if score #pr_breakout_balls survisland.data matches ..39 run function survisland:modes/pr_stoupy/breakout/bonus/clone_ball
execute if score #pr_breakout_balls survisland.data matches ..39 run function survisland:modes/pr_stoupy/breakout/bonus/clone_ball

