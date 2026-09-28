
#> survisland:modes/pr_stoupy/duo/body/apply_phase
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/body/next_phase
#			survisland:modes/pr_stoupy/duo/body/shuffle_slots
#

# Deal the current command set again, even when the group is already in that part
execute if score @s survisland.pr_stoupy_duo.phase matches 0 run return run function survisland:modes/pr_stoupy/duo/body/enter_phase/laboratoire

