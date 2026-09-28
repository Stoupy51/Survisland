
#> survisland:modes/pr_stoupy/duo/body/mount_player
#
# @executed	as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50]
#
# @within	survisland:modes/pr_stoupy/duo/body/remount [ as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] ]
#			survisland:modes/pr_stoupy/duo/body/remount [ as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group] ]
#

execute on vehicle run return 0
execute if entity @s[tag=survisland.pr_stoupy_duo.click] run return run function survisland:modes/pr_stoupy/duo/body/mount_seat
ride @s mount @n[type=mannequin,tag=survisland.pr_stoupy_duo.body,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..0.5]
function survisland:modes/pr_stoupy/duo/body/read_player

