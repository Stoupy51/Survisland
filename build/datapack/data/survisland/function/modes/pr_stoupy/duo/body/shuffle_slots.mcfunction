
#> survisland:modes/pr_stoupy/duo/body/shuffle_slots
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/shuffle_slots [ at @s ]
#			survisland:modes/pr_stoupy/duo/here/shuffle_slots [ at @s ]
#

# Everyone of this group moves to the next slot, then the current command set is dealt again
scoreboard players operation #pr_stoupy_duo_group survisland.data = @s survisland.pr_stoupy_duo.group
scoreboard players add @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] survisland.pr_stoupy_duo 1
scoreboard players set @a[tag=survisland.pr_stoupy_duo,scores={survisland.pr_stoupy_duo=3..},predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] survisland.pr_stoupy_duo 1
function survisland:modes/pr_stoupy/duo/body/apply_phase

