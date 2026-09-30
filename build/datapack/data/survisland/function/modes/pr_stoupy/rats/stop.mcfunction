
#> survisland:modes/pr_stoupy/rats/stop
#
# @within	???
#

# Every arena, everywhere
execute as @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat] run function survisland:modes/pr_stoupy/rats/remove_rat
kill @e[type=minecraft:item_display,tag=survisland.pr_rats.carried]
scoreboard players reset * survisland.pr_rats.carried
schedule clear survisland:modes/pr_stoupy/rats/tick

