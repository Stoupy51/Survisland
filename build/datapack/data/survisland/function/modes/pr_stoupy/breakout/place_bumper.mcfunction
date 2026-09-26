
#> survisland:modes/pr_stoupy/breakout/place_bumper
#
# @executed	as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
#
# @within	survisland:modes/pr_stoupy/breakout/place_bumpers [ as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] ]
#

# First cell of the bumper of slot k: (2k - 1) * width / 8 - 1
scoreboard players operation #pr_breakout_slot survisland.data = @s survisland.pr_breakout
scoreboard players operation #pr_breakout_color survisland.data = @s survisland.pr_breakout.color
scoreboard players operation #pr_breakout_offset survisland.data = @s survisland.pr_breakout
scoreboard players operation #pr_breakout_offset survisland.data *= #2 survisland.data
scoreboard players remove #pr_breakout_offset survisland.data 1
scoreboard players operation #pr_breakout_offset survisland.data *= #pr_breakout_width survisland.data
scoreboard players operation #pr_breakout_offset survisland.data /= #8 survisland.data
execute store result storage survisland:pr_breakout bumper.offset int 1 run scoreboard players remove #pr_breakout_offset survisland.data 1
execute at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] rotated as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] run function survisland:modes/pr_stoupy/breakout/summon_bumper with storage survisland:pr_breakout bumper

