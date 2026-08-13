
#> survisland:modes/all_together/body/apply_phase
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/next_phase
#			survisland:modes/all_together/body/shuffle_slots
#

execute if score @s survisland.all_together.phase matches 0 run return run function survisland:modes/all_together/body/set_phase/prologue
execute if score @s survisland.all_together.phase matches 1 run return run function survisland:modes/all_together/body/set_phase/clairiere
execute if score @s survisland.all_together.phase matches 2 run return run function survisland:modes/all_together/body/set_phase/riviere
execute if score @s survisland.all_together.phase matches 3 run return run function survisland:modes/all_together/body/set_phase/fort
execute if score @s survisland.all_together.phase matches 4 run return run function survisland:modes/all_together/body/set_phase/donjon

