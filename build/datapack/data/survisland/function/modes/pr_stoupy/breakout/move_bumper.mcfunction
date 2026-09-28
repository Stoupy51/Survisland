
#> survisland:modes/pr_stoupy/breakout/move_bumper
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/steer [ at @s ]
#

# @s is a bumper standing on its first block, facing along the field
execute if score #pr_breakout_dir survisland.data matches 1 positioned ^ ^ ^2 align xyz unless entity @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,dx=0,dy=0,dz=0] positioned ~0.5 ~ ~0.5 if block ~ ~ ~ minecraft:air run return run function survisland:modes/pr_stoupy/breakout/step_forward
execute if score #pr_breakout_dir survisland.data matches -1 positioned ^ ^ ^-1 align xyz unless entity @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,dx=0,dy=0,dz=0] positioned ~0.5 ~ ~0.5 if block ~ ~ ~ minecraft:air run function survisland:modes/pr_stoupy/breakout/step_backward

