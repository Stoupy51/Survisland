
#> survisland:modes/pr_stoupy/breakout/example/build
#
# @executed	at @s & rotated as @s
#
# @within	survisland:modes/pr_stoupy/breakout/here/example [ at @s & rotated as @s ]
#

# The booths stand 3/4 of the height in front of the field, their floor 2 blocks under its middle so the eyes are level with it
function survisland:modes/pr_stoupy/breakout/load_arena
execute store result storage survisland:pr_breakout example.width int 1 run scoreboard players get #pr_breakout_width survisland.data
execute store result storage survisland:pr_breakout example.height int 1 run scoreboard players get #pr_breakout_height survisland.data
execute store result storage survisland:pr_breakout example.middle int 0.5 run scoreboard players get #pr_breakout_width survisland.data
scoreboard players operation #pr_breakout_offset survisland.data = #pr_breakout_height survisland.data
scoreboard players operation #pr_breakout_offset survisland.data *= #3 survisland.data
execute store result storage survisland:pr_breakout example.front int -1 run scoreboard players operation #pr_breakout_offset survisland.data /= #4 survisland.data
scoreboard players operation #pr_breakout_offset survisland.data = #pr_breakout_height survisland.data
scoreboard players operation #pr_breakout_offset survisland.data /= #2 survisland.data
execute store result storage survisland:pr_breakout example.floor int 1 run scoreboard players remove #pr_breakout_offset survisland.data 2
function survisland:modes/pr_stoupy/breakout/example/frame with storage survisland:pr_breakout example

scoreboard players set #pr_breakout_offset survisland.data 1
scoreboard players operation #pr_breakout_offset survisland.data *= #pr_breakout_width survisland.data
execute store result storage survisland:pr_breakout example.u int 1 run scoreboard players operation #pr_breakout_offset survisland.data /= #8 survisland.data
data modify storage survisland:pr_breakout example.block set value "minecraft:red_concrete"
function survisland:modes/pr_stoupy/breakout/example/booth with storage survisland:pr_breakout example

scoreboard players set #pr_breakout_offset survisland.data 3
scoreboard players operation #pr_breakout_offset survisland.data *= #pr_breakout_width survisland.data
execute store result storage survisland:pr_breakout example.u int 1 run scoreboard players operation #pr_breakout_offset survisland.data /= #8 survisland.data
data modify storage survisland:pr_breakout example.block set value "minecraft:light_blue_concrete"
function survisland:modes/pr_stoupy/breakout/example/booth with storage survisland:pr_breakout example

scoreboard players set #pr_breakout_offset survisland.data 5
scoreboard players operation #pr_breakout_offset survisland.data *= #pr_breakout_width survisland.data
execute store result storage survisland:pr_breakout example.u int 1 run scoreboard players operation #pr_breakout_offset survisland.data /= #8 survisland.data
data modify storage survisland:pr_breakout example.block set value "minecraft:lime_concrete"
function survisland:modes/pr_stoupy/breakout/example/booth with storage survisland:pr_breakout example

scoreboard players set #pr_breakout_offset survisland.data 7
scoreboard players operation #pr_breakout_offset survisland.data *= #pr_breakout_width survisland.data
execute store result storage survisland:pr_breakout example.u int 1 run scoreboard players operation #pr_breakout_offset survisland.data /= #8 survisland.data
data modify storage survisland:pr_breakout example.block set value "minecraft:yellow_concrete"
function survisland:modes/pr_stoupy/breakout/example/booth with storage survisland:pr_breakout example

