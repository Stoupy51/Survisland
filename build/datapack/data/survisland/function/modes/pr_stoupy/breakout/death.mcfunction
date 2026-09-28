
#> survisland:modes/pr_stoupy/breakout/death
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/ball_tick
#

# @s is the ball that fell, lost for nothing while its player has another one in play
scoreboard players operation #pr_breakout_slot survisland.data = @s survisland.pr_breakout
tag @s add survisland.pr_breakout.lost
execute if entity @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,tag=!survisland.pr_breakout.lost,predicate=survisland:modes/pr_stoupy/breakout/same_slot] run return run kill @s

# Its last ball: every ball of the arena is taken back and relaunched after the countdown
data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value {"text": "Balle perdue !", "color": "#01FE41"}
kill @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
scoreboard players set #pr_breakout_state survisland.data 1
scoreboard players set #pr_breakout_timer survisland.data 140
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:entity.generic.explode master @s ~ ~ ~ 0.6 1.4

