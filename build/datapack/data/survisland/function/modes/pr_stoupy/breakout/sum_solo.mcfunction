
#> survisland:modes/pr_stoupy/breakout/sum_solo
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/count_bricks
#

scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_red survisland.data
scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_light_blue survisland.data
scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_lime survisland.data
scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_yellow survisland.data

