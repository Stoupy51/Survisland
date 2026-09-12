
#> survisland:modes/all_together/body/mount_seat
#
# @executed	as @a[tag=survisland.all_together,distance=..50]
#
# @within	survisland:modes/all_together/body/mount_player
#

# Another group is within reach at this radius, so the seat is picked by its group and the ride is issued from it
tag @s add survisland.all_together.mounting
execute as @e[type=item_display,tag=survisland.all_together.seat,distance=..50] if score @s survisland.all_together.group = #all_together_group survisland.data run ride @a[tag=survisland.all_together.mounting,limit=1] mount @s
tag @s remove survisland.all_together.mounting
function survisland:modes/all_together/body/read_player

