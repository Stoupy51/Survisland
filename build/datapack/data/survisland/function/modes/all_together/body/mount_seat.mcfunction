
#> survisland:modes/all_together/body/mount_seat
#
# @executed	as @a[tag=survisland.all_together,predicate=survisland:modes/all_together/same_group,distance=..50]
#
# @within	survisland:modes/all_together/body/mount_player
#

# Another group may be within reach at this radius, so the seat is picked by its group
ride @s mount @n[type=item_display,tag=survisland.all_together.seat,predicate=survisland:modes/all_together/same_group,distance=..50]
function survisland:modes/all_together/body/read_player

