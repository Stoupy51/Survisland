
#> survisland:modes/pr_stoupy/breakout/measure_bumper
#
# @executed	as @e[type=minecraft:block_display,tag=survisland.pr_breakout.bumper,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
#
# @within	survisland:modes/pr_stoupy/breakout/bumper_hit [ as @e[type=minecraft:block_display,tag=survisland.pr_breakout.bumper,predicate=survisland:modes/pr_stoupy/breakout/same_arena] ]
#

# @s is a bumper, u its first block: the ball above it lands on slice (rel + 500) * 8 / 2000
scoreboard players operation #pr_breakout_rel survisland.data = #pr_breakout_u survisland.data
scoreboard players operation #pr_breakout_rel survisland.data -= @s survisland.pr_breakout.u
execute unless score #pr_breakout_rel survisland.data matches -500..1500 run return 0
scoreboard players add #pr_breakout_rel survisland.data 500
scoreboard players operation #pr_breakout_rel survisland.data *= #8 survisland.data
scoreboard players operation #pr_breakout_rel survisland.data /= #2000 survisland.data
execute if score #pr_breakout_rel survisland.data matches 8.. run scoreboard players set #pr_breakout_rel survisland.data 7
scoreboard players operation #pr_breakout_zone survisland.data = #pr_breakout_rel survisland.data

