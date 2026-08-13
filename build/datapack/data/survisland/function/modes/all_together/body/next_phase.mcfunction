
#> survisland:modes/all_together/body/next_phase
#
# @executed	at @s
#
# @within	survisland:modes/all_together/next_phase [ at @s ]
#			survisland:modes/all_together/here/next_phase [ at @s ]
#

scoreboard players add @s survisland.all_together.phase 1
execute if score @s survisland.all_together.phase matches 5.. run scoreboard players set @s survisland.all_together.phase 0
function survisland:modes/all_together/body/apply_phase

