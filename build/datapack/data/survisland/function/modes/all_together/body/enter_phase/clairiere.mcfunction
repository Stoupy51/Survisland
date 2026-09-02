
#> survisland:modes/all_together/body/enter_phase/clairiere
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/setup_sensors
#			survisland:modes/all_together/body/set_phase/clairiere
#			survisland:modes/all_together/body/apply_phase
#

# Remember which part this group is running and how sprinting is triggered
scoreboard players set @s survisland.all_together.phase 0
scoreboard players set @s survisland.all_together.sprint 0

# Single scan of the group: every player is dealt its own command set
execute as @a[tag=survisland.all_together] if score @s survisland.all_together.group = @n[type=mannequin,tag=survisland.all_together.body] survisland.all_together.group run function survisland:modes/all_together/body/deal/clairiere
execute as @a[tag=survisland.all_together.look] if score @s survisland.all_together.group = @n[type=mannequin,tag=survisland.all_together.body] survisland.all_together.group run data modify entity @n[type=mannequin,tag=survisland.all_together.body] profile set from entity @s profile

