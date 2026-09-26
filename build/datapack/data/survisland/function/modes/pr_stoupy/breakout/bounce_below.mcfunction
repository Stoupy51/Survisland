
#> survisland:modes/pr_stoupy/breakout/bounce_below
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/ball_tick
#

execute if score #pr_breakout_v survisland.data < #pr_breakout_bumper_top survisland.data run return run function survisland:modes/pr_stoupy/breakout/bumper_hit
execute positioned ~ ~-0.3 ~ run function survisland:modes/pr_stoupy/breakout/hit_brick

