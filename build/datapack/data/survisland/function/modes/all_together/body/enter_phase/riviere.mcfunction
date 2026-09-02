
#> survisland:modes/all_together/body/enter_phase/riviere
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/set_phase/riviere
#			survisland:modes/all_together/body/apply_phase
#

# Remember which part this group is running
scoreboard players set @s survisland.all_together.phase 1
scoreboard players operation #all_together_group survisland.data = @s survisland.all_together.group

# Single scan of the group: every player is dealt its own command set, then put back on the right vehicle
execute as @a[tag=survisland.all_together,distance=..16] if score @s survisland.all_together.group = #all_together_group survisland.data run function survisland:modes/all_together/body/deal/riviere
function survisland:modes/all_together/body/remount

