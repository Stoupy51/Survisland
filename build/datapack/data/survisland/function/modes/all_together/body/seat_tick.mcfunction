
#> survisland:modes/all_together/body/seat_tick
#
# @executed	rotated as @s & anchored eyes & positioned ^ ^ ^0.6 & as @e[type=item_display,tag=survisland.all_together.seat,distance=..3]
#
# @within	survisland:modes/all_together/body/tick [ rotated as @s & anchored eyes & positioned ^ ^ ^0.6 & as @e[type=item_display,tag=survisland.all_together.seat,distance=..3] ]
#

# The seat is dropped on the point the caller computed, in front of the mannequin eyes
tp @s ~ ~ ~
execute on passengers run function survisland:modes/all_together/body/read_player
execute on passengers run function survisland:modes/all_together/body/aim

