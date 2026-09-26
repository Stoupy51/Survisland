
#> survisland:modes/pr_stoupy/orbit/dive
#
# @executed	at @s & facing entity @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] feet
#
# @within	survisland:modes/pr_stoupy/orbit/phantoms_tick [ at @s & facing entity @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] feet ]
#

tp @s ^ ^ ^0.18 ~ ~
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] if entity @s[distance=..3] run function survisland:modes/pr_stoupy/orbit/thief_swallowed

