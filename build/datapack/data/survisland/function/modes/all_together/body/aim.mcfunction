
#> survisland:modes/all_together/body/aim
#
# @executed	rotated as @s
#
# @within	survisland:modes/all_together/body/tick [ rotated as @s ]
#			survisland:modes/all_together/body/seat_tick
#

# Yaw first, from the flattened aim: a point straight above the feet has no direction to read a yaw from
execute anchored feet positioned as @s rotated ~ 0 positioned ^ ^ ^8 run rotate @s facing ~ ~ ~

# Then the pitch, nudged along the yaw just set so aiming straight down keeps that yaw instead of losing it
execute anchored feet positioned as @s positioned ^ ^ ^8 rotated as @s positioned ^ ^ ^0.01 run rotate @s facing ~ ~ ~

