
#> survisland:modes/all_together/body/shuffle_slots
#
# @executed	at @s
#
# @within	survisland:modes/all_together/shuffle_slots [ at @s ]
#			survisland:modes/all_together/here/shuffle_slots [ at @s ]
#

# Everyone of this group moves to the next slot, then the current command set is dealt again
scoreboard players operation #all_together_group survisland.data = @s survisland.all_together.group
execute as @a[tag=survisland.all_together,distance=..16] if score @s survisland.all_together.group = #all_together_group survisland.data run scoreboard players add @s survisland.all_together 1
execute as @a[tag=survisland.all_together,scores={survisland.all_together=5..},distance=..16] if score @s survisland.all_together.group = #all_together_group survisland.data run scoreboard players set @s survisland.all_together 1
function survisland:modes/all_together/body/apply_phase

