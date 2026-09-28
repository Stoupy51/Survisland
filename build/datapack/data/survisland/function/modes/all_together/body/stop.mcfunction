
#> survisland:modes/all_together/body/stop
#
# @executed	at @s
#
# @within	survisland:modes/all_together/here/stop [ at @s ]
#			survisland:modes/all_together/stop [ at @s ]
#

# Single scan of the group: every player is released, tags included
scoreboard players operation #all_together_group survisland.data = @s survisland.all_together.group
execute as @a[tag=survisland.all_together,predicate=survisland:modes/all_together/same_group,distance=..50] run function survisland:modes/all_together/body/release_player
kill @e[type=item_display,tag=survisland.all_together.seat,predicate=survisland:modes/all_together/same_group,distance=..50]
kill @s

