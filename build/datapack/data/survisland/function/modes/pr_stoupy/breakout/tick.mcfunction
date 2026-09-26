
#> survisland:modes/pr_stoupy/breakout/tick
#
# @within	survisland:modes/pr_stoupy/breakout/tick 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/breakout/start 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/breakout/here/next_level 1t replace [ scheduled ]
#

scoreboard players set #pr_breakout_active survisland.data 0
execute as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner] at @s run function survisland:modes/pr_stoupy/breakout/arena_tick
execute if score #pr_breakout_active survisland.data matches 1.. run schedule function survisland:modes/pr_stoupy/breakout/tick 1t replace

