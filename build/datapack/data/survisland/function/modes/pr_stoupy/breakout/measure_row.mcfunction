
#> survisland:modes/pr_stoupy/breakout/measure_row
#
# @executed	at @s & rotated as @s
#
# @within	survisland:modes/pr_stoupy/breakout/measure_field
#			survisland:modes/pr_stoupy/breakout/measure_row [ positioned ^ ^ ^1 ]
#

# The bumper row is empty up to the frame, but for the barriers of bumpers left over
execute unless block ~ ~ ~ #minecraft:air unless block ~ ~ ~ minecraft:barrier run return 0
scoreboard players add #pr_breakout_width survisland.data 1
execute if score #pr_breakout_width survisland.data matches ..63 positioned ^ ^ ^1 run function survisland:modes/pr_stoupy/breakout/measure_row

