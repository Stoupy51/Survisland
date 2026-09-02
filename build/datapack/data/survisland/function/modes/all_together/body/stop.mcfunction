
#> survisland:modes/all_together/body/stop
#
# @executed	at @s
#
# @within	survisland:modes/all_together/here/stop [ at @s ]
#			survisland:modes/all_together/stop [ at @s ]
#

# Single scan of the group: every player is released, tags included
scoreboard players operation #all_together_group survisland.data = @s survisland.all_together.group
execute as @a[tag=survisland.all_together,distance=..16] if score @s survisland.all_together.group = #all_together_group survisland.data run function survisland:modes/all_together/body/release_player
execute as @e[type=item_display,tag=survisland.all_together.seat,distance=..16] if score @s survisland.all_together.group = #all_together_group survisland.data run kill @s
kill @s

