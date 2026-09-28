
#> survisland:modes/pr_stoupy/breakout/place_screen
#
# @executed	align xyz & positioned ~0.5 ~ ~0.5
#
# @within	survisland:modes/pr_stoupy/breakout/setup_corner
#			survisland:modes/pr_stoupy/breakout/start [ at @s ]
#

# @s is the corner, at itself: the screen hangs in the middle of the field, on the side of the players (^- with invert:0, ^+ with invert:1)
kill @e[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
execute store result storage survisland:pr_breakout middle.u double 0.5 run scoreboard players remove #pr_breakout_width survisland.data 1
scoreboard players add #pr_breakout_width survisland.data 1
execute store result storage survisland:pr_breakout middle.v double 0.5 run scoreboard players get #pr_breakout_height survisland.data
scoreboard players operation #pr_breakout_side survisland.data = #pr_breakout_invert survisland.data
scoreboard players operation #pr_breakout_side survisland.data *= #2 survisland.data
execute store result storage survisland:pr_breakout middle.side double 1.5 run scoreboard players remove #pr_breakout_side survisland.data 1
execute rotated as @s run function survisland:modes/pr_stoupy/breakout/summon_screen with storage survisland:pr_breakout middle

