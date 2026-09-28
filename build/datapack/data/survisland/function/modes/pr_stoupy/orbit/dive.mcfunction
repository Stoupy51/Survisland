
#> survisland:modes/pr_stoupy/orbit/dive
#
# @executed	at @s & rotated as @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1]
#
# @within	survisland:modes/pr_stoupy/orbit/phantoms_tick [ at @s & rotated as @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] ]
#

# Along the push of the hole until the wall it is painted on
tp @s ^ ^ ^0.18 ~ ~
execute positioned ^ ^ ^1 unless block ~ ~ ~ #minecraft:air run function survisland:modes/pr_stoupy/orbit/thief_swallowed

