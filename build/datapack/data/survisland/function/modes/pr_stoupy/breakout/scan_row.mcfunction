
#> survisland:modes/pr_stoupy/breakout/scan_row
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & rotated as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & positioned ~ ~1 ~
#
# @within	survisland:modes/pr_stoupy/breakout/count_bricks [ at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & rotated as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & positioned ~ ~1 ~ ]
#			survisland:modes/pr_stoupy/breakout/scan_row [ positioned ~ ~1 ~ ]
#

scoreboard players set #pr_breakout_scan_u survisland.data 0
function survisland:modes/pr_stoupy/breakout/scan_cell
scoreboard players add #pr_breakout_scan_v survisland.data 1
execute if score #pr_breakout_scan_v survisland.data < #pr_breakout_height survisland.data positioned ~ ~1 ~ run function survisland:modes/pr_stoupy/breakout/scan_row

