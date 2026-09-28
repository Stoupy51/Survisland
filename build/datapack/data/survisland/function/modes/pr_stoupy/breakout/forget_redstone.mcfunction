
#> survisland:modes/pr_stoupy/breakout/forget_redstone
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/start [ at @s ]
#

# The redstone block of the previous game is taken back with its marker
execute if block ~ ~ ~ minecraft:redstone_block run setblock ~ ~ ~ minecraft:air
kill @s

