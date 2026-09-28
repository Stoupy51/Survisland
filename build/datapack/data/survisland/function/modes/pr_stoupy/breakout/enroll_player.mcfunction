
#> survisland:modes/pr_stoupy/breakout/enroll_player
#
# @executed	as @a[tag=survisland.pr_breakout.new,sort=nearest] & at @s
#
# @within	survisland:modes/pr_stoupy/breakout/start [ as @a[tag=survisland.pr_breakout.new,sort=nearest] & at @s ]
#

scoreboard players add #pr_breakout_slot_counter survisland.data 1
scoreboard players operation @s survisland.pr_breakout = #pr_breakout_slot_counter survisland.data
scoreboard players operation @s survisland.pr_breakout.arena = #pr_breakout_arena survisland.data
tag @s add survisland.pr_breakout
scoreboard players set @s survisland.pr_breakout.color -1
# The tp may leave the player above its booth, so the first colored block down to 3 blocks under the feet counts
function survisland:modes/pr_stoupy/breakout/read_color
execute if score @s survisland.pr_breakout.color matches -1 positioned ~ ~-1 ~ run function survisland:modes/pr_stoupy/breakout/read_color
execute if score @s survisland.pr_breakout.color matches -1 positioned ~ ~-2 ~ run function survisland:modes/pr_stoupy/breakout/read_color

# Seated for the whole game: its keys only steer the bumper, with no slowness zooming the view
# A seated player sinks by its vehicle attachment of 0.6, so the seat is raised by as much
execute positioned ~ ~0.6 ~ summon minecraft:item_display run function survisland:modes/pr_stoupy/breakout/new_seat
ride @s mount @n[type=minecraft:item_display,tag=survisland.pr_breakout.new_seat]
tag @e[type=minecraft:item_display,tag=survisland.pr_breakout.new_seat] remove survisland.pr_breakout.new_seat

