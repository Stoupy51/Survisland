
#> survisland:modes/pr_stoupy/breakout/probe
#
# @executed	positioned ^ ^0.2 ^0.5
#
# @within	survisland:modes/pr_stoupy/breakout/side_bounce [ positioned ^ ^0.2 ^0.5 ]
#			survisland:modes/pr_stoupy/breakout/side_bounce [ positioned ^ ^0.01 ^0.5 ]
#			survisland:modes/pr_stoupy/breakout/side_bounce [ positioned ^ ^0.38 ^0.5 ]
#			survisland:modes/pr_stoupy/breakout/side_bounce [ positioned ^ ^-0.3 ^0.5 ]
#			survisland:modes/pr_stoupy/breakout/side_bounce [ positioned ^ ^0.7 ^0.5 ]
#			survisland:modes/pr_stoupy/breakout/vertical_bounce [ positioned ^ ^ ^0 ]
#			survisland:modes/pr_stoupy/breakout/vertical_bounce [ positioned ^ ^ ^0.19 ]
#			survisland:modes/pr_stoupy/breakout/vertical_bounce [ positioned ^ ^ ^-0.19 ]
#			survisland:modes/pr_stoupy/breakout/vertical_bounce [ positioned ^ ^ ^-0.5 ]
#

# The first solid block found is the one the ball bounced on, and only breaks if it is a brick of the ball
execute if block ~ ~ ~ #minecraft:air run return 0
scoreboard players set #pr_breakout_hit survisland.data 1
function survisland:modes/pr_stoupy/breakout/hit_brick

