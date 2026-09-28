
#> survisland:modes/pr_stoupy/orbit/find_pad
#
# @executed	as @a[tag=!survisland.pr_orbit,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative] & at @s
#
# @within	survisland:modes/pr_stoupy/orbit/enroll_player
#

execute positioned ~ ~-1 ~ if block ~ ~ ~ #survisland:pr_stoupy/start_pad run return run function survisland:modes/pr_stoupy/orbit/take_pad
execute positioned ~0.3 ~-1 ~0.3 if block ~ ~ ~ #survisland:pr_stoupy/start_pad run return run function survisland:modes/pr_stoupy/orbit/take_pad
execute positioned ~-0.3 ~-1 ~0.3 if block ~ ~ ~ #survisland:pr_stoupy/start_pad run return run function survisland:modes/pr_stoupy/orbit/take_pad
execute positioned ~0.3 ~-1 ~-0.3 if block ~ ~ ~ #survisland:pr_stoupy/start_pad run return run function survisland:modes/pr_stoupy/orbit/take_pad
execute positioned ~-0.3 ~-1 ~-0.3 if block ~ ~ ~ #survisland:pr_stoupy/start_pad run return run function survisland:modes/pr_stoupy/orbit/take_pad

