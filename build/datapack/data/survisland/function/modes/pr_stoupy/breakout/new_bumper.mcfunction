
#> survisland:modes/pr_stoupy/breakout/new_bumper
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] & rotated as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1]
#
# @within	survisland:modes/pr_stoupy/breakout/summon_bumper
#

tag @s add survisland.pr_breakout.bumper
tp @s ~ ~ ~ ~ ~
scoreboard players operation @s survisland.pr_breakout = #pr_breakout_slot survisland.data
scoreboard players operation @s survisland.pr_breakout.arena = #pr_breakout_arena survisland.data
scoreboard players operation @s survisland.pr_breakout.color = #pr_breakout_color survisland.data
execute if score @s survisland.pr_breakout.color matches 0 run data modify entity @s data.block set value "minecraft:white_concrete"
execute if score @s survisland.pr_breakout.color matches 1 run data modify entity @s data.block set value "minecraft:orange_concrete"
execute if score @s survisland.pr_breakout.color matches 2 run data modify entity @s data.block set value "minecraft:magenta_concrete"
execute if score @s survisland.pr_breakout.color matches 3 run data modify entity @s data.block set value "minecraft:light_blue_concrete"
execute if score @s survisland.pr_breakout.color matches 4 run data modify entity @s data.block set value "minecraft:yellow_concrete"
execute if score @s survisland.pr_breakout.color matches 5 run data modify entity @s data.block set value "minecraft:lime_concrete"
execute if score @s survisland.pr_breakout.color matches 6 run data modify entity @s data.block set value "minecraft:pink_concrete"
execute if score @s survisland.pr_breakout.color matches 7 run data modify entity @s data.block set value "minecraft:gray_concrete"
execute if score @s survisland.pr_breakout.color matches 8 run data modify entity @s data.block set value "minecraft:light_gray_concrete"
execute if score @s survisland.pr_breakout.color matches 9 run data modify entity @s data.block set value "minecraft:cyan_concrete"
execute if score @s survisland.pr_breakout.color matches 10 run data modify entity @s data.block set value "minecraft:purple_concrete"
execute if score @s survisland.pr_breakout.color matches 11 run data modify entity @s data.block set value "minecraft:blue_concrete"
execute if score @s survisland.pr_breakout.color matches 12 run data modify entity @s data.block set value "minecraft:brown_concrete"
execute if score @s survisland.pr_breakout.color matches 13 run data modify entity @s data.block set value "minecraft:green_concrete"
execute if score @s survisland.pr_breakout.color matches 14 run data modify entity @s data.block set value "minecraft:red_concrete"
execute if score @s survisland.pr_breakout.color matches 15 run data modify entity @s data.block set value "minecraft:black_concrete"
function #bs.position:get_pos {scale:1000}
execute if score #pr_breakout_axis survisland.data matches 0 run scoreboard players operation @s survisland.pr_breakout.u = @s bs.pos.x
execute if score #pr_breakout_axis survisland.data matches 1 run scoreboard players operation @s survisland.pr_breakout.u = @s bs.pos.z
function survisland:modes/pr_stoupy/breakout/draw_bumper with entity @s data

