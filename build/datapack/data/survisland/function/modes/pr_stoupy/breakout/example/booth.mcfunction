
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

# A 1x1 glass booth open on top, above its start pad from which tp:"~ ~5 ~" lands the player on the colored floor
$execute positioned ^$(front) ^$(floor) ^$(u) run fill ^-1 ^1 ^-1 ^1 ^2 ^1 minecraft:glass
$execute positioned ^$(front) ^$(floor) ^$(u) run fill ^ ^1 ^ ^ ^2 ^ minecraft:air
$execute positioned ^$(front) ^$(floor) ^$(u) run setblock ~ ~ ~ $(block)
$execute positioned ^$(front) ^$(floor) ^$(u) run setblock ~ ~-5 ~ minecraft:emerald_block

