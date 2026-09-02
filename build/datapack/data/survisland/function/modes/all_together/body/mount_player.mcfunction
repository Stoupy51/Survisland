
#> survisland:modes/all_together/body/mount_player
#
# @executed	as @a[tag=survisland.all_together,distance=..16]
#
# @within	survisland:modes/all_together/body/remount [ as @a[tag=survisland.all_together,distance=..16] ]
#			survisland:modes/all_together/body/remount [ as @a[tag=survisland.all_together] ]
#

execute on vehicle run return 0
execute if entity @s[tag=survisland.all_together.click] run return run function survisland:modes/all_together/body/mount_seat
ride @s mount @e[type=mannequin,tag=survisland.all_together.body,distance=..0.5,limit=1]
function survisland:modes/all_together/body/read_player

