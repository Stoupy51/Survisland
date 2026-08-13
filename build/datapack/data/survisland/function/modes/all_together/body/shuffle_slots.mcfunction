
#> survisland:modes/all_together/body/shuffle_slots
#
# @executed	at @s
#
# @within	survisland:modes/all_together/shuffle_slots [ at @s ]
#			survisland:modes/all_together/here/shuffle_slots [ at @s ]
#

# Everyone of this group moves to the next slot, then the current command set is dealt again
scoreboard players add @a[tag=survisland.all_together,distance=..50] survisland.all_together 1
scoreboard players set @a[tag=survisland.all_together,distance=..50,scores={survisland.all_together=5..}] survisland.all_together 1
function survisland:modes/all_together/body/apply_phase

