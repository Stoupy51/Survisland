
#> survisland:modes/pr_stoupy/breakout/summon_screen
#
# @executed	rotated as @s
#
# @within	survisland:modes/pr_stoupy/breakout/place_screen with storage survisland:pr_breakout middle [ rotated as @s ]
#
# @args		side (unknown)
#			v (unknown)
#			u (unknown)
#

# Facing the players and parallel to the bricks, so looking up at it never tilts it into them
$execute positioned ^$(side) ^$(v) ^$(u) facing ^$(side) ^ ^ summon minecraft:text_display run function survisland:modes/pr_stoupy/breakout/new_screen

