
#> survisland:modes/pr_stoupy/breakout/new_seat
#
# @executed	align xz & positioned ~0.5 ~0.6 ~0.5
#
# @within	survisland:modes/pr_stoupy/breakout/enroll_player [ align xz & positioned ~0.5 ~0.6 ~0.5 ]
#

tag @s add survisland.pr_breakout.seat
tag @s add survisland.pr_breakout.new_seat
scoreboard players operation @s survisland.pr_breakout = #pr_breakout_slot_counter survisland.data
scoreboard players operation @s survisland.pr_breakout.arena = #pr_breakout_arena survisland.data

