
#> survisland:modes/pr_stoupy/breakout/example/bricks
#
# @executed	at @s & rotated as @s
#
# @within	survisland:modes/pr_stoupy/breakout/here/example [ at @s & rotated as @s ]
#			survisland:modes/pr_stoupy/breakout/here/example_level [ at @s & rotated as @s ]
#

# @s is a corner: the brick rows are emptied, then the top 6 of them under the free top row are filled
function survisland:modes/pr_stoupy/breakout/load_arena
execute store result storage survisland:pr_breakout example.last_row int 1 run scoreboard players remove #pr_breakout_height survisland.data 1
execute store result storage survisland:pr_breakout example.last_cell int 1 run scoreboard players remove #pr_breakout_width survisland.data 1
scoreboard players add #pr_breakout_width survisland.data 1
execute store result storage survisland:pr_breakout example.first_row int 1 run scoreboard players remove #pr_breakout_height survisland.data 6
scoreboard players add #pr_breakout_height survisland.data 7
function survisland:modes/pr_stoupy/breakout/example/fill_bricks with storage survisland:pr_breakout example

