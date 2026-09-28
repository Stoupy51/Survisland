
#> survisland:modes/pr_stoupy/breakout/break_brick
#
# @executed	positioned ~0.5 ~0.2 ~
#
# @within	survisland:modes/pr_stoupy/breakout/hit_brick
#

# destroy gives the real break particles and sound, its drop is removed right away
setblock ~ ~ ~ minecraft:air destroy
kill @e[type=minecraft:item,distance=..1.5]
scoreboard players remove #pr_breakout_remaining survisland.data 1
execute if score #pr_breakout_remaining survisland.data matches ..0 run return run function survisland:modes/pr_stoupy/breakout/level_cleared
function survisland:modes/pr_stoupy/breakout/bonus/count

