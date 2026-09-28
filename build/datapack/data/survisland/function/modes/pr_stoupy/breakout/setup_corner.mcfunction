
#> survisland:modes/pr_stoupy/breakout/setup_corner
#
# @executed	align xyz & positioned ~0.5 ~ ~0.5
#
# @within	survisland:modes/pr_stoupy/breakout/here/setup [ align xyz & positioned ~0.5 ~ ~0.5 ]
#

tag @s add survisland.pr_breakout.corner

# Facing along the field, so ^ ^ ^n is the n-th cell of a row
execute if score #pr_breakout_axis survisland.data matches 0 run rotate @s -90 0
execute if score #pr_breakout_axis survisland.data matches 1 run rotate @s 0 0

function #bs.position:get_pos {scale:1000}
scoreboard players operation #pr_breakout_death_v survisland.data = @s bs.pos.y
scoreboard players add #pr_breakout_death_v survisland.data 500
scoreboard players operation #pr_breakout_bumper_top survisland.data = @s bs.pos.y
scoreboard players add #pr_breakout_bumper_top survisland.data 1300
function survisland:modes/pr_stoupy/breakout/save_arena

# The screen hangs in the middle of the field, on the side of the players: ^-1 with invert:0, ^1 with invert:1
execute store result storage survisland:pr_breakout middle.u int 0.5 run scoreboard players get #pr_breakout_width survisland.data
execute store result storage survisland:pr_breakout middle.v int 0.5 run scoreboard players get #pr_breakout_height survisland.data
scoreboard players operation #pr_breakout_side survisland.data = #pr_breakout_invert survisland.data
scoreboard players operation #pr_breakout_side survisland.data *= #2 survisland.data
execute store result storage survisland:pr_breakout middle.side double 0.6 run scoreboard players remove #pr_breakout_side survisland.data 1
execute rotated as @s run function survisland:modes/pr_stoupy/breakout/summon_screen with storage survisland:pr_breakout middle

