
#> survisland:modes/pr_stoupy/breakout/bonus/count
#
# @executed	positioned ~0.5 ~0.2 ~
#
# @within	survisland:modes/pr_stoupy/breakout/break_brick
#

# @s is the ball that broke a brick
scoreboard players add #pr_breakout_broken survisland.data 1
execute if score #pr_breakout_broken survisland.data matches ..14 run return 0
scoreboard players set #pr_breakout_broken survisland.data 0
execute if score #pr_breakout_bonus survisland.data matches 0 run function survisland:modes/pr_stoupy/breakout/bonus/speed
execute if score #pr_breakout_bonus survisland.data matches 1 run function survisland:modes/pr_stoupy/breakout/bonus/split
scoreboard players add #pr_breakout_bonus survisland.data 1
scoreboard players operation #pr_breakout_bonus survisland.data %= #2 survisland.data

