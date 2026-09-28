
#> survisland:modes/pr_stoupy/breakout/step_forward
#
# @executed	positioned ^ ^ ^2 & align xyz & positioned ~0.5 ~ ~0.5
#
# @within	survisland:modes/pr_stoupy/breakout/move_bumper [ positioned ^ ^ ^2 & align xyz & positioned ~0.5 ~ ~0.5 ]
#

setblock ~ ~ ~ minecraft:barrier
execute at @s run setblock ~ ~ ~ minecraft:air
execute at @s run tp @s ^ ^ ^1
scoreboard players add @s survisland.pr_breakout.u 1000

