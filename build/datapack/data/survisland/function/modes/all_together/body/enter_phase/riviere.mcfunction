
#> survisland:modes/all_together/body/enter_phase/riviere
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/set_phase/riviere
#			survisland:modes/all_together/body/apply_phase
#

# Remember which part this group is running and how sprinting is triggered
scoreboard players set @s survisland.all_together.phase 1
scoreboard players set @s survisland.all_together.sprint 1

# Single scan of the group: every player is dealt its own command set
execute as @a[tag=survisland.all_together,distance=..3] run function survisland:modes/all_together/body/deal/riviere

