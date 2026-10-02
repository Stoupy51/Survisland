
#> survisland:modes/pr_stoupy/duo/body/stop
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/here/stop [ at @s ]
#			survisland:modes/pr_stoupy/duo/stop [ at @s ]
#			survisland:modes/pr_stoupy/duo/here/reward [ at @s ]
#			survisland:modes/pr_stoupy/here/clear
#

# Single scan of the group: every player is released, tags included
scoreboard players operation #pr_stoupy_duo_group survisland.data = @s survisland.pr_stoupy_duo.group
execute as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] run function survisland:modes/pr_stoupy/duo/body/release_player
kill @e[type=item_display,tag=survisland.pr_stoupy_duo.seat,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50]
kill @s

