
#> survisland:modes/pr_stoupy/breakout/count_cell
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & rotated as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & positioned ~ ~1 ~
#
# @within	survisland:modes/pr_stoupy/breakout/scan_cell
#

execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/white run return run scoreboard players add #pr_breakout_bricks_white survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/orange run return run scoreboard players add #pr_breakout_bricks_orange survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/magenta run return run scoreboard players add #pr_breakout_bricks_magenta survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/light_blue run return run scoreboard players add #pr_breakout_bricks_light_blue survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/yellow run return run scoreboard players add #pr_breakout_bricks_yellow survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/lime run return run scoreboard players add #pr_breakout_bricks_lime survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/pink run return run scoreboard players add #pr_breakout_bricks_pink survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/gray run return run scoreboard players add #pr_breakout_bricks_gray survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/light_gray run return run scoreboard players add #pr_breakout_bricks_light_gray survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/cyan run return run scoreboard players add #pr_breakout_bricks_cyan survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/purple run return run scoreboard players add #pr_breakout_bricks_purple survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/blue run return run scoreboard players add #pr_breakout_bricks_blue survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/brown run return run scoreboard players add #pr_breakout_bricks_brown survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/green run return run scoreboard players add #pr_breakout_bricks_green survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/red run return run scoreboard players add #pr_breakout_bricks_red survisland.data 1
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/black run return run scoreboard players add #pr_breakout_bricks_black survisland.data 1

