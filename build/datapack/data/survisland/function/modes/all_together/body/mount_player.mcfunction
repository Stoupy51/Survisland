
#> survisland:modes/all_together/body/mount_player
#
# @executed	as @a[tag=survisland.all_together,predicate=survisland:modes/all_together/same_group,distance=..50]
#
# @within	survisland:modes/all_together/body/remount [ as @a[tag=survisland.all_together,predicate=survisland:modes/all_together/same_group,distance=..50] ]
#			survisland:modes/all_together/body/remount [ as @a[tag=survisland.all_together,predicate=survisland:modes/all_together/same_group] ]
#

execute on vehicle run return 0
execute if entity @s[tag=survisland.all_together.click] run return run function survisland:modes/all_together/body/mount_seat
ride @s mount @n[type=mannequin,tag=survisland.all_together.body,predicate=survisland:modes/all_together/same_group,distance=..0.5]
function survisland:modes/all_together/body/read_player

