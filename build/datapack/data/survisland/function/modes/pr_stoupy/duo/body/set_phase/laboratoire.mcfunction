
#> survisland:modes/pr_stoupy/duo/body/set_phase/laboratoire
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/set_phase/laboratoire [ at @s ]
#			survisland:modes/pr_stoupy/duo/here/set_phase/laboratoire [ at @s ]
#

# Idempotent, so the command block of the part can keep firing on the group standing on it
execute if score @s survisland.pr_stoupy_duo.phase matches 0 run return 0
function survisland:modes/pr_stoupy/duo/body/enter_phase/laboratoire

