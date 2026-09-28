
#> survisland:modes/pr_stoupy/breakout/countdown_tick
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/arena_tick
#

scoreboard players remove #pr_breakout_timer survisland.data 1
execute if score #pr_breakout_timer survisland.data matches 20 run function survisland:modes/pr_stoupy/breakout/count/1
execute if score #pr_breakout_timer survisland.data matches 40 run function survisland:modes/pr_stoupy/breakout/count/2
execute if score #pr_breakout_timer survisland.data matches 60 run function survisland:modes/pr_stoupy/breakout/count/3
execute if score #pr_breakout_timer survisland.data matches 80 run function survisland:modes/pr_stoupy/breakout/count/4
execute if score #pr_breakout_timer survisland.data matches 100 run function survisland:modes/pr_stoupy/breakout/count/5
execute if score #pr_breakout_timer survisland.data matches ..0 run function survisland:modes/pr_stoupy/breakout/launch

