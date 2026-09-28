
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
function survisland:modes/pr_stoupy/breakout/place_screen

