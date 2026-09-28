
#> survisland:modes/pr_stoupy/rats/carry_one
#
# @executed	as @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier]
#
# @within	survisland:modes/pr_stoupy/rats/carry [ as @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier] ]
#

# Stacked above the head of the catcher, facing where it looks
execute if score @s survisland.pr_rats.index matches 1 run tp @s ~ ~2.1 ~ ~ 0
execute if score @s survisland.pr_rats.index matches 2 run tp @s ~ ~2.45 ~ ~ 0
execute if score @s survisland.pr_rats.index matches 3 run tp @s ~ ~2.8 ~ ~ 0

