
#> survisland:modes/pr_stoupy/rats/victory
#
# @executed	as the player & at current position
#
# @within	survisland:modes/pr_stoupy/rats/collect
#

# The rats still free or carried are gone once the goal is met, the caged ones stay
function survisland:modes/pr_stoupy/give_star {trial:"Les rats de labo"}
execute as @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat,tag=!survisland.pr_rats.caged,predicate=survisland:modes/pr_stoupy/rats/same_arena] run function survisland:modes/pr_stoupy/rats/remove_rat
kill @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_arena]
execute as @a[scores={survisland.pr_rats.carried=1..}] run function survisland:modes/pr_stoupy/rats/recount

