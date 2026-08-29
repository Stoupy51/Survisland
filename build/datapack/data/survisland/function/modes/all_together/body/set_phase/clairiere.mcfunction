
#> survisland:modes/all_together/body/set_phase/clairiere
#
# @executed	at @s
#
# @within	survisland:modes/all_together/set_phase/clairiere [ at @s ]
#			survisland:modes/all_together/here/set_phase/clairiere [ at @s ]
#

# Idempotent, so the command block of the part can keep firing on the group standing on it
execute if score @s survisland.all_together.phase matches 0 run return 0
function survisland:modes/all_together/body/enter_phase/clairiere

