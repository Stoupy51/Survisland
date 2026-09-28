
#> survisland:modes/pr_stoupy/breakout/measure_field
#
# @executed	at @s & rotated as @s
#
# @within	survisland:modes/pr_stoupy/breakout/start [ at @s & rotated as @s ]
#

# @s is the corner, at and rotated as itself: the field is measured up to its frame at every start, whatever the setup was given
scoreboard players set #pr_breakout_width survisland.data 0
function survisland:modes/pr_stoupy/breakout/measure_row
scoreboard players set #pr_breakout_height survisland.data 1
execute positioned ~ ~1 ~ run function survisland:modes/pr_stoupy/breakout/measure_column

