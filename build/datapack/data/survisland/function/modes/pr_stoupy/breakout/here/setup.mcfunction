
#> survisland:modes/pr_stoupy/breakout/here/setup
#
# @within	survisland:modes/pr_stoupy/breakout/here/example {width:$(width),height:$(height),axis:"$(axis)",invert:0}
#
# @args		width (unknown)
#			height (unknown)
#			invert (int)
#			axis (string)
#

# Positioned on the bottom left cell of the field, width and height in blocks, axis along which the field extends
function survisland:modes/pr_stoupy/breakout/objectives
execute as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,distance=..16] run function survisland:modes/pr_stoupy/breakout/forget_arena

scoreboard players add #pr_breakout_arena_counter survisland.data 1
scoreboard players operation #pr_breakout_arena survisland.data = #pr_breakout_arena_counter survisland.data
scoreboard players set #pr_breakout_state survisland.data 0
scoreboard players set #pr_breakout_level survisland.data 0
$scoreboard players set #pr_breakout_width survisland.data $(width)
$scoreboard players set #pr_breakout_height survisland.data $(height)
$scoreboard players set #pr_breakout_invert survisland.data $(invert)
$data modify storage survisland:pr_breakout axis set value "$(axis)"
scoreboard players set #pr_breakout_axis survisland.data 0
execute if data storage survisland:pr_breakout {axis:"z"} run scoreboard players set #pr_breakout_axis survisland.data 1
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function survisland:modes/pr_stoupy/breakout/setup_corner
tellraw @a[distance=..16] {"text":"Casse-briques : terrain configuré.","color":"green"}

