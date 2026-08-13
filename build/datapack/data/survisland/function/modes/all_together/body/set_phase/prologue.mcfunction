
#> survisland:modes/all_together/body/set_phase/prologue
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/setup_sensors
#			survisland:modes/all_together/body/apply_phase
#			survisland:modes/all_together/set_phase/prologue [ at @s ]
#			survisland:modes/all_together/here/set_phase/prologue [ at @s ]
#

# Remember which part this group is running and how sprinting is triggered
scoreboard players set @s survisland.all_together.phase 0
scoreboard players set @s survisland.all_together.sprint 0

# Single scan of the group: every player is dealt its own command set
execute as @a[tag=survisland.all_together,distance=..50] run function survisland:modes/all_together/body/deal/prologue

