
#> survisland:modes/pr_stoupy/rats/remove_rat
#
# @executed	as @n[type=minecraft:ocelot,tag=survisland.pr_rats.caught]
#
# @within	survisland:modes/pr_stoupy/rats/catch [ as @n[type=minecraft:ocelot,tag=survisland.pr_rats.caught] ]
#			survisland:modes/pr_stoupy/rats/here/stop [ as @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat,predicate=survisland:modes/pr_stoupy/rats/same_arena] ]
#			survisland:modes/pr_stoupy/rats/stop [ as @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat] ]
#

execute on passengers run kill @s
tp @s ~ -1000 ~
kill @s

