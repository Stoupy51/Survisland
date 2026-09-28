
#> survisland:modes/pr_stoupy/breakout/scan_cell
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & rotated as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & positioned ~ ~1 ~
#
# @within	survisland:modes/pr_stoupy/breakout/scan_row
#			survisland:modes/pr_stoupy/breakout/scan_cell [ positioned ^ ^ ^1 ]
#

execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/any run function survisland:modes/pr_stoupy/breakout/count_cell
scoreboard players add #pr_breakout_scan_u survisland.data 1
execute if score #pr_breakout_scan_u survisland.data < #pr_breakout_width survisland.data positioned ^ ^ ^1 run function survisland:modes/pr_stoupy/breakout/scan_cell

