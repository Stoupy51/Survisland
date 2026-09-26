
#> survisland:modes/pr_stoupy/breakout/steer
#
# @executed	as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
#
# @within	survisland:modes/pr_stoupy/breakout/play_tick [ as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] ]
#

# @s is a player, its left and right keys move its own bumper along the field
scoreboard players set #pr_breakout_dir survisland.data 0
execute if predicate survisland:input/right run scoreboard players add #pr_breakout_dir survisland.data 1
execute if predicate survisland:input/left run scoreboard players remove #pr_breakout_dir survisland.data 1
execute if score #pr_breakout_dir survisland.data matches 0 run return 0
execute if score #pr_breakout_invert survisland.data matches 1 run scoreboard players operation #pr_breakout_dir survisland.data *= #-1 survisland.data
scoreboard players operation #pr_breakout_slot survisland.data = @s survisland.pr_breakout
execute as @e[type=minecraft:marker,tag=survisland.pr_breakout.bumper,predicate=survisland:modes/pr_stoupy/breakout/same_slot] at @s run function survisland:modes/pr_stoupy/breakout/move_bumper

