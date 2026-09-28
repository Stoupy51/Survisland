
#> survisland:modes/pr_stoupy/breakout/bonus/multiball
#
# @executed	positioned ^ ^0.2 ^0.5
#
# @within	survisland:modes/pr_stoupy/breakout/hit_brick
#

# Positioned on a multiball brick, which any ball breaks without it counting as a brick of the level
function survisland:modes/pr_stoupy/breakout/shatter
execute store result score #pr_breakout_balls survisland.data if entity @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
execute as @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run function survisland:modes/pr_stoupy/breakout/bonus/multiply_ball
title @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] actionbar {"text": "Bonus : balles x5 !", "color": "#01FE41"}
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 0.8

