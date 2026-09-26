
#> survisland:modes/pr_stoupy/breakout/summon_bumper
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & rotated as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1]
#
# @within	survisland:modes/pr_stoupy/breakout/place_bumper with storage survisland:pr_breakout bumper [ at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & rotated as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] ]
#
# @args		offset (unknown)
#

$execute positioned ^ ^ ^$(offset) summon minecraft:marker run function survisland:modes/pr_stoupy/breakout/new_bumper

