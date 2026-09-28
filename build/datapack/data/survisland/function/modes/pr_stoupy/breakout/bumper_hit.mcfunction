
#> survisland:modes/pr_stoupy/breakout/bumper_hit
#
# @executed	rotated -90 0
#
# @within	survisland:modes/pr_stoupy/breakout/bounce_below
#

scoreboard players set #pr_breakout_zone survisland.data -1
execute as @e[type=minecraft:block_display,tag=survisland.pr_breakout.bumper,predicate=survisland:modes/pr_stoupy/breakout/same_arena] run function survisland:modes/pr_stoupy/breakout/measure_bumper
execute if score #pr_breakout_zone survisland.data matches -1 run return 0
function survisland:modes/pr_stoupy/breakout/apply_zone
playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 1.4

