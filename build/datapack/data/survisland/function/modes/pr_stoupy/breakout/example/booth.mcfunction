
#> survisland:modes/pr_stoupy/breakout/example/booth
#
# @executed	at @s & rotated as @s
#
# @within	survisland:modes/pr_stoupy/breakout/example/build with storage survisland:pr_breakout example
#
# @args		front (unknown)
#			floor (unknown)
#			u (unknown)
#			block (unknown)
#

# A 1x1 glass booth open on top, so a player drops in and cannot jump out
$execute positioned ^$(front) ^$(floor) ^$(u) run fill ^-1 ^1 ^-1 ^1 ^2 ^1 minecraft:glass
$execute positioned ^$(front) ^$(floor) ^$(u) run fill ^ ^1 ^ ^ ^2 ^ minecraft:air
$execute positioned ^$(front) ^$(floor) ^$(u) run setblock ~ ~ ~ $(block)

