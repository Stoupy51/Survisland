
#> survisland:modes/pr_stoupy/breakout/launch
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/countdown_tick
#

scoreboard players set #pr_breakout_state survisland.data 2
execute at @e[type=minecraft:marker,tag=survisland.pr_breakout.level_block,predicate=survisland:modes/pr_stoupy/breakout/same_arena] run setblock ~ ~ ~ minecraft:air
function survisland:modes/pr_stoupy/breakout/count_bricks
data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value {"text": ""}
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:block.note_block.pling ambient @s ~ ~ ~ 1 2
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] run function survisland:modes/pr_stoupy/breakout/spawn_ball

