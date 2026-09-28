
#> survisland:modes/pr_stoupy/breakout/spawn_ball
#
# @executed	as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
#
# @within	survisland:modes/pr_stoupy/breakout/launch [ as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] ]
#

# @s is a player, its ball appears two blocks above the middle of its bumper
scoreboard players operation #pr_breakout_slot survisland.data = @s survisland.pr_breakout
scoreboard players operation #pr_breakout_color survisland.data = @s survisland.pr_breakout.color
execute as @e[type=minecraft:block_display,tag=survisland.pr_breakout.bumper,predicate=survisland:modes/pr_stoupy/breakout/same_slot] at @s positioned ^ ^2 ^0.5 summon minecraft:sulfur_cube run function survisland:modes/pr_stoupy/breakout/new_ball

