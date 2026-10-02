
#> survisland:modes/pr_stoupy/breakout/break_brick
#
# @executed	positioned ^ ^0.2 ^0.5
#
# @within	survisland:modes/pr_stoupy/breakout/hit_brick
#

# Concrete cracks into the stained glass of its color, broken by the next hit like any other brick
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/concrete as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:block.glass.place ambient @s ~ ~ ~ 1 1.4
execute if block ~ ~ ~ minecraft:white_concrete run return run setblock ~ ~ ~ minecraft:white_stained_glass
execute if block ~ ~ ~ minecraft:orange_concrete run return run setblock ~ ~ ~ minecraft:orange_stained_glass
execute if block ~ ~ ~ minecraft:magenta_concrete run return run setblock ~ ~ ~ minecraft:magenta_stained_glass
execute if block ~ ~ ~ minecraft:light_blue_concrete run return run setblock ~ ~ ~ minecraft:light_blue_stained_glass
execute if block ~ ~ ~ minecraft:yellow_concrete run return run setblock ~ ~ ~ minecraft:yellow_stained_glass
execute if block ~ ~ ~ minecraft:lime_concrete run return run setblock ~ ~ ~ minecraft:lime_stained_glass
execute if block ~ ~ ~ minecraft:pink_concrete run return run setblock ~ ~ ~ minecraft:pink_stained_glass
execute if block ~ ~ ~ minecraft:gray_concrete run return run setblock ~ ~ ~ minecraft:gray_stained_glass
execute if block ~ ~ ~ minecraft:cyan_concrete run return run setblock ~ ~ ~ minecraft:cyan_stained_glass
execute if block ~ ~ ~ minecraft:purple_concrete run return run setblock ~ ~ ~ minecraft:purple_stained_glass
execute if block ~ ~ ~ minecraft:blue_concrete run return run setblock ~ ~ ~ minecraft:blue_stained_glass
execute if block ~ ~ ~ minecraft:brown_concrete run return run setblock ~ ~ ~ minecraft:brown_stained_glass
execute if block ~ ~ ~ minecraft:green_concrete run return run setblock ~ ~ ~ minecraft:green_stained_glass
execute if block ~ ~ ~ minecraft:red_concrete run return run setblock ~ ~ ~ minecraft:red_stained_glass
execute if block ~ ~ ~ minecraft:black_concrete run return run setblock ~ ~ ~ minecraft:black_stained_glass

function survisland:modes/pr_stoupy/breakout/shatter
scoreboard players remove #pr_breakout_remaining survisland.data 1
# The count only covers the field as it was at the level start, so a count reaching 0 is checked by a new scan
execute if score #pr_breakout_remaining survisland.data matches ..0 run function survisland:modes/pr_stoupy/breakout/count_bricks
execute if score #pr_breakout_remaining survisland.data matches ..0 run return run function survisland:modes/pr_stoupy/breakout/level_cleared
function survisland:modes/pr_stoupy/breakout/bonus/count

