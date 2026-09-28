
#> survisland:modes/pr_stoupy/breakout/vertical_bounce
#
# @executed	positioned ~ ~0.7 ~
#
# @within	survisland:modes/pr_stoupy/breakout/bounces [ positioned ~ ~0.7 ~ ]
#			survisland:modes/pr_stoupy/breakout/bounce_below [ positioned ~ ~-0.3 ~ ]
#

scoreboard players set #pr_breakout_hit survisland.data 0
execute if score #pr_breakout_hit survisland.data matches 0 positioned ^ ^ ^0 run function survisland:modes/pr_stoupy/breakout/probe
execute if score #pr_breakout_hit survisland.data matches 0 positioned ^ ^ ^0.19 run function survisland:modes/pr_stoupy/breakout/probe
execute if score #pr_breakout_hit survisland.data matches 0 positioned ^ ^ ^-0.19 run function survisland:modes/pr_stoupy/breakout/probe
execute if score #pr_breakout_hit survisland.data matches 0 positioned ^ ^ ^-0.5 run function survisland:modes/pr_stoupy/breakout/probe

