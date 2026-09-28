
#> survisland:modes/all_together/body/mark_seat
#
# @executed	rotated as @s & anchored eyes & positioned ^ ^ ^0.6 & as @e[type=item_display,tag=survisland.all_together.seat,predicate=survisland:modes/all_together/same_group,distance=..50]
#
# @within	survisland:modes/all_together/body/seat_tick
#

data modify storage survisland:all_together seat set from entity @s Pos
kill @s

