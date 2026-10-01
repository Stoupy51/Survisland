
#> survisland:modes/pr_stoupy/breakout/stop
#
# @within	(public)
#

# Every field, everywhere
execute as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner] run function survisland:modes/pr_stoupy/breakout/stop_corner
schedule clear survisland:modes/pr_stoupy/breakout/tick

