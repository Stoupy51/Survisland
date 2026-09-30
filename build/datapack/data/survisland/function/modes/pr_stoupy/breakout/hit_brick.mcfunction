
#> survisland:modes/pr_stoupy/breakout/hit_brick
#
# @executed	positioned ^ ^0.2 ^0.5
#
# @within	survisland:modes/pr_stoupy/breakout/probe
#

# Positioned on the probed block, run as the ball that bounced
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/purple run return run function survisland:modes/pr_stoupy/breakout/bonus/multiball
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/any run function survisland:modes/pr_stoupy/breakout/break_brick

