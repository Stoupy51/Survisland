
#> survisland:modes/pr_stoupy/breakout/bonus/speed
#
# @executed	positioned ~0.5 ~0.2 ~
#
# @within	survisland:modes/pr_stoupy/breakout/bonus/count
#

# Twice as fast until the ball is lost, a second one on the same ball is wasted
execute if score @s survisland.pr_breakout.speed matches 2 run return 0
scoreboard players set @s survisland.pr_breakout.speed 2
execute if score #pr_breakout_axis survisland.data matches 0 store result entity @s Motion[0] double 0.002 run scoreboard players get #pr_breakout_mu survisland.data
execute if score #pr_breakout_axis survisland.data matches 1 store result entity @s Motion[2] double 0.002 run scoreboard players get #pr_breakout_mu survisland.data
execute store result entity @s Motion[1] double 0.002 run scoreboard players get #pr_breakout_mv survisland.data

title @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] actionbar {"text": "Bonus : vitesse x2 !", "color": "#01FE41"}
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1.2

