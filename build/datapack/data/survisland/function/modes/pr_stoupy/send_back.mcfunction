
#> survisland:modes/pr_stoupy/send_back
#
# @executed	as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50]
#
# @within	survisland:modes/pr_stoupy/duo/body/release_player
#			survisland:modes/pr_stoupy/mirror/stop_session [ as @a[tag=survisland.pr_mirror,predicate=survisland:modes/pr_stoupy/mirror/same_session] ]
#			survisland:modes/pr_stoupy/mirror/stop [ as @a[tag=survisland.pr_mirror] ]
#

execute store result storage survisland:pr_stoupy back.x double 0.01 run scoreboard players get @s survisland.pr_stoupy.x
execute store result storage survisland:pr_stoupy back.y double 0.01 run scoreboard players get @s survisland.pr_stoupy.y
execute store result storage survisland:pr_stoupy back.z double 0.01 run scoreboard players get @s survisland.pr_stoupy.z
function survisland:modes/pr_stoupy/send_back_to with storage survisland:pr_stoupy back
tag @s add survisland.pr_stoupy.back

