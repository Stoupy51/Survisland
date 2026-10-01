
#> survisland:modes/pr_stoupy/orbit/stop
#
# @within	(public)
#

# Every room, everywhere
execute as @e[type=minecraft:marker,tag=survisland.pr_orbit.hole] run function survisland:modes/pr_stoupy/orbit/stop_hole
schedule clear survisland:modes/pr_stoupy/orbit/tick

