
#> survisland:modes/pr_stoupy/breakout/here/next_level
#
# @within	string in survisland:modes/pr_stoupy/breakout/level_cleared
#

# To call once the next level is cloned in: the nearest field takes its balls back and goes on from the countdown
execute unless score @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] survisland.pr_breakout.state matches 1.. run return fail
execute as @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] run function survisland:modes/pr_stoupy/breakout/next_level
schedule function survisland:modes/pr_stoupy/breakout/tick 1t replace

