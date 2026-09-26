
#> survisland:modes/pr_stoupy/rats/here/stop
#
# @within	???
#

# The arena of the nearest cage: its rats, free, carried or caged, then the carriers count what they still hold
scoreboard players operation #pr_rats_arena survisland.data = @n[type=minecraft:marker,tag=survisland.pr_rats.cage] survisland.pr_rats.arena
execute as @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat,predicate=survisland:modes/pr_stoupy/rats/same_arena] run function survisland:modes/pr_stoupy/rats/remove_rat
kill @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_arena]
kill @e[type=minecraft:item_display,tag=survisland.pr_rats.caged,predicate=survisland:modes/pr_stoupy/rats/same_arena]
scoreboard players set @e[type=minecraft:marker,tag=survisland.pr_rats.cage,predicate=survisland:modes/pr_stoupy/rats/same_arena] survisland.pr_rats.caged 0
execute as @a[scores={survisland.pr_rats.carried=1..}] run function survisland:modes/pr_stoupy/rats/recount

