
#> survisland:modes/pr_stoupy/duo/body/next_phase
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/next_phase [ at @s ]
#			survisland:modes/pr_stoupy/duo/here/next_phase [ at @s ]
#

scoreboard players add @s survisland.pr_stoupy_duo.phase 1
execute if score @s survisland.pr_stoupy_duo.phase matches 1.. run scoreboard players set @s survisland.pr_stoupy_duo.phase 0
function survisland:modes/pr_stoupy/duo/body/apply_phase

