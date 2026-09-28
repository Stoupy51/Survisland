
#> survisland:modes/pr_stoupy/breakout/release_player
#
# @executed	as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
#
# @within	survisland:modes/pr_stoupy/breakout/stop_arena [ as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] ]
#			survisland:modes/pr_stoupy/breakout/abort_colorless [ as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] ]
#

attribute @s minecraft:movement_speed modifier remove survisland:pr_breakout_frozen
tag @s remove survisland.pr_breakout

