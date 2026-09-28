
#> survisland:modes/pr_stoupy/breakout/measure_column
#
# @executed	positioned ~ ~1 ~
#
# @within	survisland:modes/pr_stoupy/breakout/measure_field [ positioned ~ ~1 ~ ]
#			survisland:modes/pr_stoupy/breakout/measure_column [ positioned ~ ~1 ~ ]
#

# The first column holds only air and bricks up to the frame
execute unless block ~ ~ ~ #minecraft:air unless block ~ ~ ~ #survisland:pr_stoupy/breakout/any run return 0
scoreboard players add #pr_breakout_height survisland.data 1
execute if score #pr_breakout_height survisland.data matches ..63 positioned ~ ~1 ~ run function survisland:modes/pr_stoupy/breakout/measure_column

