
#> survisland:modes/pr_stoupy/duo/body/mount_seat
#
# @executed	as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50]
#
# @within	survisland:modes/pr_stoupy/duo/body/mount_player
#

# Another group may be within reach at this radius, so the seat is picked by its group
ride @s mount @n[type=item_display,tag=survisland.pr_stoupy_duo.seat,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50]
function survisland:modes/pr_stoupy/duo/body/read_player

