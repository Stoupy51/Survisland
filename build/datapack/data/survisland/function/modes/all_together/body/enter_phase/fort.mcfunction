
#> survisland:modes/all_together/body/enter_phase/fort
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/set_phase/fort
#			survisland:modes/all_together/body/apply_phase
#

# Remember which part this group is running and how sprinting is triggered
scoreboard players set @s survisland.all_together.phase 2
scoreboard players set @s survisland.all_together.sprint 0

# Single scan of the group: every player is dealt its own command set
execute as @a[tag=survisland.all_together,distance=..3] run function survisland:modes/all_together/body/deal/fort

