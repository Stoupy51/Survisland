
#> survisland:modes/all_together/body/seat_tick
#
# @executed	rotated as @s & anchored eyes & positioned ^ ^ ^0.6 & as @e[type=item_display,tag=survisland.all_together.seat,predicate=survisland:modes/all_together/same_group,distance=..50]
#
# @within	survisland:modes/all_together/body/tick [ rotated as @s & anchored eyes & positioned ^ ^ ^0.6 & as @e[type=item_display,tag=survisland.all_together.seat,predicate=survisland:modes/all_together/same_group,distance=..50] ]
#			survisland:modes/all_together/body/find_seat [ as @e[type=item_display,tag=survisland.all_together.seat,predicate=survisland:modes/all_together/same_group] ]
#

# The seat is dropped on the point the caller computed, in front of the mannequin eyes
# Never with tp: it teleports the rider too, and a teleported player has every click refused until its client answers
execute summon minecraft:marker run function survisland:modes/all_together/body/mark_seat
data modify entity @s Pos set from storage survisland:all_together seat
execute on passengers run function survisland:modes/all_together/body/read_player
execute on passengers unless entity @s[tag=survisland.all_together.look] run function survisland:modes/all_together/body/aim

# A rider holding both the click and the look, a solo player for instance, aims the mannequin from here
execute on passengers if entity @s[tag=survisland.all_together.look] rotated as @s as @n[type=mannequin,tag=survisland.all_together.body,predicate=survisland:modes/all_together/same_group,distance=..50] run function survisland:modes/all_together/body/aim

# Tells the caller the seat was found, whether or not it carries anyone
return 1

