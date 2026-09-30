
#> survisland:modes/pr_stoupy/rats/here/stop
#
# @within	survisland:modes/pr_stoupy/here/clear
#

# The arena of the nearest collector: its rats, free, carried or caged, then the carriers count what they still hold
scoreboard players operation #pr_rats_arena survisland.data = @n[type=minecraft:interaction,tag=survisland.pr_rats.collector] survisland.pr_rats.arena
execute as @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat,predicate=survisland:modes/pr_stoupy/rats/same_arena] run function survisland:modes/pr_stoupy/rats/remove_rat
kill @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_arena]
execute as @a[scores={survisland.pr_rats.carried=1..}] run function survisland:modes/pr_stoupy/rats/recount

