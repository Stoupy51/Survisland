
#> survisland:modes/all_together/body/stop
#
# @executed	at @s
#
# @within	survisland:modes/all_together/start [ at @s ]
#			survisland:modes/all_together/here/stop [ at @s ]
#			survisland:modes/all_together/stop [ at @s ]
#

# Single scan of the group: every player is released, tags included
execute as @a[tag=survisland.all_together,distance=..50] run function survisland:modes/all_together/body/release_player
kill @s

