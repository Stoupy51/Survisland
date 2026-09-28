
#> survisland:modes/pr_stoupy/duo/body/aim
#
# @executed	rotated as @s
#
# @within	survisland:modes/pr_stoupy/duo/body/tick [ rotated as @s ]
#			survisland:modes/pr_stoupy/duo/body/seat_tick
#			survisland:modes/pr_stoupy/duo/body/seat_tick [ rotated as @s & as @n[type=mannequin,tag=survisland.pr_stoupy_duo.body,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] ]
#

# Yaw first, from the flattened aim: a point straight above the feet has no direction to read a yaw from
execute anchored feet positioned as @s rotated ~ 0 positioned ^ ^ ^8 run rotate @s facing ~ ~ ~

# Then the pitch, nudged along the yaw just set so aiming straight down keeps that yaw instead of losing it
execute anchored feet positioned as @s positioned ^ ^ ^8 rotated as @s positioned ^ ^ ^0.01 run rotate @s facing ~ ~ ~

