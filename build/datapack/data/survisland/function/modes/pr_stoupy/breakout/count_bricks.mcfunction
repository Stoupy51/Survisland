
#> survisland:modes/pr_stoupy/breakout/count_bricks
#
# @within	survisland:modes/pr_stoupy/breakout/begin_level
#

# Raster scan of the brick rows, once per level: breaks are then counted down one by one
scoreboard players set #pr_breakout_bricks_white survisland.data 0
scoreboard players set #pr_breakout_bricks_orange survisland.data 0
scoreboard players set #pr_breakout_bricks_magenta survisland.data 0
scoreboard players set #pr_breakout_bricks_light_blue survisland.data 0
scoreboard players set #pr_breakout_bricks_yellow survisland.data 0
scoreboard players set #pr_breakout_bricks_lime survisland.data 0
scoreboard players set #pr_breakout_bricks_pink survisland.data 0
scoreboard players set #pr_breakout_bricks_gray survisland.data 0
scoreboard players set #pr_breakout_bricks_light_gray survisland.data 0
scoreboard players set #pr_breakout_bricks_cyan survisland.data 0
scoreboard players set #pr_breakout_bricks_purple survisland.data 0
scoreboard players set #pr_breakout_bricks_blue survisland.data 0
scoreboard players set #pr_breakout_bricks_brown survisland.data 0
scoreboard players set #pr_breakout_bricks_green survisland.data 0
scoreboard players set #pr_breakout_bricks_red survisland.data 0
scoreboard players set #pr_breakout_bricks_black survisland.data 0
scoreboard players set #pr_breakout_scan_v survisland.data 1
execute at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] rotated as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] positioned ~ ~1 ~ run function survisland:modes/pr_stoupy/breakout/scan_row
scoreboard players set #pr_breakout_remaining survisland.data 0
execute if score #pr_breakout_solo survisland.data matches 1 run return run function survisland:modes/pr_stoupy/breakout/sum_solo
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=0}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_white survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=1}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_orange survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=2}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_magenta survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=3}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_light_blue survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=4}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_yellow survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=5}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_lime survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=6}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_pink survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=7}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_gray survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=8}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_light_gray survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=9}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_cyan survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=10}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_purple survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=11}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_blue survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=12}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_brown survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=13}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_green survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=14}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_red survisland.data
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=15}] run scoreboard players operation #pr_breakout_remaining survisland.data += #pr_breakout_bricks_black survisland.data

