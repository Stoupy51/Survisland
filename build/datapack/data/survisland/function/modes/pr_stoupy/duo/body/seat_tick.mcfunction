
#> survisland:modes/pr_stoupy/duo/body/seat_tick
#
# @executed	rotated as @s & anchored eyes & positioned ^ ^ ^0.6 & as @e[type=item_display,tag=survisland.pr_stoupy_duo.seat,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50]
#
# @within	survisland:modes/pr_stoupy/duo/body/tick [ rotated as @s & anchored eyes & positioned ^ ^ ^0.6 & as @e[type=item_display,tag=survisland.pr_stoupy_duo.seat,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] ]
#			survisland:modes/pr_stoupy/duo/body/find_seat [ as @e[type=item_display,tag=survisland.pr_stoupy_duo.seat,predicate=survisland:modes/pr_stoupy/duo/same_group] ]
#

# The seat is dropped on the point the caller computed, in front of the mannequin eyes
tp @s ~ ~ ~
execute on passengers run function survisland:modes/pr_stoupy/duo/body/read_player
execute on passengers unless entity @s[tag=survisland.pr_stoupy_duo.look] run function survisland:modes/pr_stoupy/duo/body/aim

# A rider holding both the click and the look, a solo player for instance, aims the mannequin from here
execute on passengers if entity @s[tag=survisland.pr_stoupy_duo.look] rotated as @s as @n[type=mannequin,tag=survisland.pr_stoupy_duo.body,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] run function survisland:modes/pr_stoupy/duo/body/aim

# Tells the caller the seat was found, whether or not it carries anyone
return 1

