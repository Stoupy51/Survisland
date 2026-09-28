
#> survisland:modes/pr_stoupy/breakout/example/brick_row
#
# @executed	at @s & rotated as @s
#
# @within	survisland:modes/pr_stoupy/breakout/example/fill_bricks
#			survisland:modes/pr_stoupy/breakout/example/brick_row [ positioned ~ ~1 ~ ]
#

scoreboard players set #pr_breakout_cell survisland.data 0
function survisland:modes/pr_stoupy/breakout/example/brick_cell
scoreboard players add #pr_breakout_row survisland.data 1
execute if score #pr_breakout_row survisland.data matches ..5 positioned ~ ~1 ~ run function survisland:modes/pr_stoupy/breakout/example/brick_row

