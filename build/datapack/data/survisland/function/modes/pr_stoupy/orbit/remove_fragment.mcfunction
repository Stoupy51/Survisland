
#> survisland:modes/pr_stoupy/orbit/remove_fragment
#
# @executed	as @e[type=minecraft:item_display,tag=...,predicate=survisland:modes/pr_stoupy/orbit/same_arena,distance=..1.6,limit=1,sort=nearest]
#
# @within	survisland:modes/pr_stoupy/orbit/pick_up [ as @e[type=minecraft:item_display,tag=...,predicate=survisland:modes/pr_stoupy/orbit/same_arena,distance=..1.6,limit=1,sort=nearest] ]
#			survisland:modes/pr_stoupy/orbit/grab
#			survisland:modes/pr_stoupy/orbit/stop_arena [ as @e[type=minecraft:item_display,tag=survisland.pr_orbit.fragment,predicate=survisland:modes/pr_stoupy/orbit/same_arena] ]
#

execute on passengers run kill @s
kill @s

