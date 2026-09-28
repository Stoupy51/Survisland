
#> survisland:modes/pr_stoupy/breakout/new_seat
#
# @executed	positioned ~ ~0.6 ~
#
# @within	survisland:modes/pr_stoupy/breakout/enroll_player [ positioned ~ ~0.6 ~ ]
#

tag @s add survisland.pr_breakout.seat
tag @s add survisland.pr_breakout.new_seat
scoreboard players operation @s survisland.pr_breakout = #pr_breakout_slot_counter survisland.data
scoreboard players operation @s survisland.pr_breakout.arena = #pr_breakout_arena survisland.data

