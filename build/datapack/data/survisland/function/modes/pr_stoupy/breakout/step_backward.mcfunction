
#> survisland:modes/pr_stoupy/breakout/step_backward
#
# @executed	positioned ^ ^ ^-1 & align xyz & positioned ~0.5 ~ ~0.5
#
# @within	survisland:modes/pr_stoupy/breakout/move_bumper with entity @s data [ positioned ^ ^ ^-1 & align xyz & positioned ~0.5 ~ ~0.5 ]
#
# @args		block (unknown)
#

$setblock ~ ~ ~ $(block)
execute at @s run setblock ^ ^ ^2 minecraft:air
execute at @s run tp @s ^ ^ ^-1
scoreboard players remove @s survisland.pr_breakout.u 1000

