
#> survisland:modes/all_together/body/apply_phase
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/next_phase
#			survisland:modes/all_together/body/shuffle_slots
#

# Deal the current command set again, even when the group is already in that part
execute if score @s survisland.all_together.phase matches 0 run return run function survisland:modes/all_together/body/enter_phase/clairiere
execute if score @s survisland.all_together.phase matches 1 run return run function survisland:modes/all_together/body/enter_phase/riviere
execute if score @s survisland.all_together.phase matches 2 run return run function survisland:modes/all_together/body/enter_phase/fort

