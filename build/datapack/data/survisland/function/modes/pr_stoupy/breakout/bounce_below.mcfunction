
#> survisland:modes/pr_stoupy/breakout/bounce_below
#
# @executed	rotated -90 0
#
# @within	survisland:modes/pr_stoupy/breakout/bounces
#

execute if score #pr_breakout_v survisland.data < #pr_breakout_bumper_top survisland.data run return run function survisland:modes/pr_stoupy/breakout/bumper_hit
execute positioned ~ ~-0.3 ~ run function survisland:modes/pr_stoupy/breakout/vertical_bounce

