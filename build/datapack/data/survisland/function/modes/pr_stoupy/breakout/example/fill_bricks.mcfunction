
#> survisland:modes/pr_stoupy/breakout/example/fill_bricks
#
# @executed	at @s & rotated as @s
#
# @within	survisland:modes/pr_stoupy/breakout/example/bricks with storage survisland:pr_breakout example
#
# @args		last_row (unknown)
#			last_cell (unknown)
#			first_row (unknown)
#

$fill ^ ^1 ^ ^ ^$(last_row) ^$(last_cell) minecraft:air
scoreboard players set #pr_breakout_row survisland.data 0
$execute positioned ~ ~$(first_row) ~ run function survisland:modes/pr_stoupy/breakout/example/brick_row

