
#> survisland:modes/pr_stoupy/breakout/hit_brick
#
# @executed	positioned ~0.5 ~0.2 ~
#
# @within	survisland:modes/pr_stoupy/breakout/ball_tick [ positioned ~0.5 ~0.2 ~ ]
#			survisland:modes/pr_stoupy/breakout/ball_tick [ positioned ~-0.5 ~0.2 ~ ]
#			survisland:modes/pr_stoupy/breakout/ball_tick [ positioned ~ ~0.2 ~0.5 ]
#			survisland:modes/pr_stoupy/breakout/ball_tick [ positioned ~ ~0.2 ~-0.5 ]
#			survisland:modes/pr_stoupy/breakout/ball_tick [ positioned ~ ~0.7 ~ ]
#			survisland:modes/pr_stoupy/breakout/bounce_below [ positioned ~ ~-0.3 ~ ]
#

# Positioned on the probed block, run as the ball that bounced
execute if score @s survisland.pr_breakout.color matches 0 if block ~ ~ ~ #survisland:pr_stoupy/breakout/white run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 1 if block ~ ~ ~ #survisland:pr_stoupy/breakout/orange run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 2 if block ~ ~ ~ #survisland:pr_stoupy/breakout/magenta run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 3 if block ~ ~ ~ #survisland:pr_stoupy/breakout/light_blue run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 4 if block ~ ~ ~ #survisland:pr_stoupy/breakout/yellow run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 5 if block ~ ~ ~ #survisland:pr_stoupy/breakout/lime run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 6 if block ~ ~ ~ #survisland:pr_stoupy/breakout/pink run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 7 if block ~ ~ ~ #survisland:pr_stoupy/breakout/gray run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 8 if block ~ ~ ~ #survisland:pr_stoupy/breakout/light_gray run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 9 if block ~ ~ ~ #survisland:pr_stoupy/breakout/cyan run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 10 if block ~ ~ ~ #survisland:pr_stoupy/breakout/purple run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 11 if block ~ ~ ~ #survisland:pr_stoupy/breakout/blue run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 12 if block ~ ~ ~ #survisland:pr_stoupy/breakout/brown run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 13 if block ~ ~ ~ #survisland:pr_stoupy/breakout/green run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 14 if block ~ ~ ~ #survisland:pr_stoupy/breakout/red run return run function survisland:modes/pr_stoupy/breakout/break_brick
execute if score @s survisland.pr_breakout.color matches 15 if block ~ ~ ~ #survisland:pr_stoupy/breakout/black run return run function survisland:modes/pr_stoupy/breakout/break_brick

