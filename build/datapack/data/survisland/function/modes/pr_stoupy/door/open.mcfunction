
#> survisland:modes/pr_stoupy/door/open
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/door/update with entity @s data
#			survisland:modes/pr_stoupy/here/clear with entity @s data
#
# @args		block (unknown)
#

# Only the door block itself is removed, whatever else was built in the doorway stays
$execute if block ~ ~ ~ $(block) run setblock ~ ~ ~ minecraft:air

