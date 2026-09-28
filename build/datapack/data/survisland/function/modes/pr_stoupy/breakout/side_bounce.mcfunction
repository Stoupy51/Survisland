
#> survisland:modes/pr_stoupy/breakout/side_bounce
#
# @executed	rotated -90 0
#
# @within	survisland:modes/pr_stoupy/breakout/bounces
#

scoreboard players set #pr_breakout_hit survisland.data 0
execute if score #pr_breakout_hit survisland.data matches 0 positioned ^ ^0.2 ^0.5 run function survisland:modes/pr_stoupy/breakout/probe
execute if score #pr_breakout_hit survisland.data matches 0 positioned ^ ^0.01 ^0.5 run function survisland:modes/pr_stoupy/breakout/probe
execute if score #pr_breakout_hit survisland.data matches 0 positioned ^ ^0.38 ^0.5 run function survisland:modes/pr_stoupy/breakout/probe
execute if score #pr_breakout_hit survisland.data matches 0 positioned ^ ^-0.3 ^0.5 run function survisland:modes/pr_stoupy/breakout/probe
execute if score #pr_breakout_hit survisland.data matches 0 positioned ^ ^0.7 ^0.5 run function survisland:modes/pr_stoupy/breakout/probe

