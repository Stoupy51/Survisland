
#> survisland:modes/pr_stoupy/orbit/return_to_pad
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/orbit/stop_arena [ at @s ]
#

# Run at a start pad, which takes back one player, and that player joins again only once off the pads
execute as @a[tag=survisland.pr_orbit,tag=!survisland.pr_orbit.back,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run function survisland:modes/pr_stoupy/orbit/land_on_pad

