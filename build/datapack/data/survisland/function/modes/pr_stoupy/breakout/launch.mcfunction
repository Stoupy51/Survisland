
#> survisland:modes/pr_stoupy/breakout/launch
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/countdown_tick
#

scoreboard players set #pr_breakout_state survisland.data 2
data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value {"text": ""}
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 2
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] run function survisland:modes/pr_stoupy/breakout/spawn_ball

