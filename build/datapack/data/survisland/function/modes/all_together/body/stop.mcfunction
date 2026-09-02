
#> survisland:modes/all_together/body/stop
#
# @executed	at @s
#
# @within	survisland:modes/all_together/here/stop [ at @s ]
#			survisland:modes/all_together/stop [ at @s ]
#

# Single scan of the group: every player is released, tags included
execute as @a[tag=survisland.all_together] if score @s survisland.all_together.group = @e[type=mannequin,tag=survisland.all_together.body,limit=1,sort=nearest] survisland.all_together.group run function survisland:modes/all_together/body/release_player
kill @s

