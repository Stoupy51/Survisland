
#> survisland:modes/pr_stoupy/door/update
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/door/tick with entity @s data [ at @s ]
#
# @args		player_tag (unknown)
#			radius (unknown)
#			block (unknown)
#

$execute unless entity @a[tag=$(player_tag),distance=..$(radius)] run return run function survisland:modes/pr_stoupy/door/open with entity @s data
$setblock ~ ~ ~ $(block)
scoreboard players add #pr_stoupy_closed survisland.data 1

