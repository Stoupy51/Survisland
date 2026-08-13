
#> survisland:modes/all_together/body/set_phase/fort
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/apply_phase
#			survisland:modes/all_together/set_phase/fort [ at @s ]
#			survisland:modes/all_together/here/set_phase/fort [ at @s ]
#

# Remember which part this group is running and how sprinting is triggered
scoreboard players set @s survisland.all_together.phase 3
scoreboard players set @s survisland.all_together.sprint 0

# Single scan of the group: every player is dealt its own command set
execute as @a[tag=survisland.all_together,distance=..50] run function survisland:modes/all_together/body/deal/fort

