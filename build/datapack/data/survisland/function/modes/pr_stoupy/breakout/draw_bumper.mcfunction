
#> survisland:modes/pr_stoupy/breakout/draw_bumper
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & rotated as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1]
#
# @within	survisland:modes/pr_stoupy/breakout/new_bumper with entity @s data
#
# @args		block (unknown)
#

$setblock ^ ^ ^0 $(block)
$setblock ^ ^ ^1 $(block)
$setblock ^ ^ ^2 $(block)

