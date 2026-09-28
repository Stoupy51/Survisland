
#> survisland:modes/pr_stoupy/breakout/apply_zone
#
# @executed	at @s & positioned ^ ^2 ^0.5
#
# @within	survisland:modes/pr_stoupy/breakout/new_ball
#			survisland:modes/pr_stoupy/breakout/bumper_hit
#			survisland:modes/pr_stoupy/breakout/bonus/new_clone
#

# @s is a ball, sent along the motion of slice #pr_breakout_zone, times its speed in percent
execute if score #pr_breakout_zone survisland.data matches 0 run scoreboard players set #pr_breakout_mu survisland.data -303
execute if score #pr_breakout_zone survisland.data matches 0 run scoreboard players set #pr_breakout_mv survisland.data 175
execute if score #pr_breakout_zone survisland.data matches 1 run scoreboard players set #pr_breakout_mu survisland.data -247
execute if score #pr_breakout_zone survisland.data matches 1 run scoreboard players set #pr_breakout_mv survisland.data 247
execute if score #pr_breakout_zone survisland.data matches 2 run scoreboard players set #pr_breakout_mu survisland.data -175
execute if score #pr_breakout_zone survisland.data matches 2 run scoreboard players set #pr_breakout_mv survisland.data 303
execute if score #pr_breakout_zone survisland.data matches 3 run scoreboard players set #pr_breakout_mu survisland.data -91
execute if score #pr_breakout_zone survisland.data matches 3 run scoreboard players set #pr_breakout_mv survisland.data 338
execute if score #pr_breakout_zone survisland.data matches 4 run scoreboard players set #pr_breakout_mu survisland.data 91
execute if score #pr_breakout_zone survisland.data matches 4 run scoreboard players set #pr_breakout_mv survisland.data 338
execute if score #pr_breakout_zone survisland.data matches 5 run scoreboard players set #pr_breakout_mu survisland.data 175
execute if score #pr_breakout_zone survisland.data matches 5 run scoreboard players set #pr_breakout_mv survisland.data 303
execute if score #pr_breakout_zone survisland.data matches 6 run scoreboard players set #pr_breakout_mu survisland.data 247
execute if score #pr_breakout_zone survisland.data matches 6 run scoreboard players set #pr_breakout_mv survisland.data 247
execute if score #pr_breakout_zone survisland.data matches 7 run scoreboard players set #pr_breakout_mu survisland.data 303
execute if score #pr_breakout_zone survisland.data matches 7 run scoreboard players set #pr_breakout_mv survisland.data 175
scoreboard players operation #pr_breakout_mu survisland.data *= @s survisland.pr_breakout.speed
scoreboard players operation #pr_breakout_mv survisland.data *= @s survisland.pr_breakout.speed
scoreboard players operation #pr_breakout_mu survisland.data /= #100 survisland.data
scoreboard players operation #pr_breakout_mv survisland.data /= #100 survisland.data
execute if score #pr_breakout_axis survisland.data matches 0 store result entity @s Motion[0] double 0.001 run scoreboard players get #pr_breakout_mu survisland.data
execute if score #pr_breakout_axis survisland.data matches 1 store result entity @s Motion[2] double 0.001 run scoreboard players get #pr_breakout_mu survisland.data
execute store result entity @s Motion[1] double 0.001 run scoreboard players get #pr_breakout_mv survisland.data

