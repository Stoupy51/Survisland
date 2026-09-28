
#> survisland:modes/pr_stoupy/breakout/count/2
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/countdown_tick
#

data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value {"text": "2", "color": "#01FE41"}
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.1

