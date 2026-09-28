
#> survisland:modes/pr_stoupy/breakout/bonus/new_clone
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/bonus/clone_ball
#

# Any slice, up or down, so the copies spread out instead of following the ball they came from
function survisland:modes/pr_stoupy/breakout/new_ball
execute store result score #pr_breakout_zone survisland.data run random value 0..7
function survisland:modes/pr_stoupy/breakout/apply_zone
execute store result score #pr_breakout_down survisland.data run random value 0..1
execute if score #pr_breakout_down survisland.data matches 1 store result entity @s Motion[1] double -0.001 run scoreboard players get #pr_breakout_mv survisland.data
execute if score #pr_breakout_down survisland.data matches 1 run scoreboard players operation #pr_breakout_mv survisland.data *= #-1 survisland.data
scoreboard players operation @s survisland.pr_breakout.mu = #pr_breakout_mu survisland.data
scoreboard players operation @s survisland.pr_breakout.mv = #pr_breakout_mv survisland.data

