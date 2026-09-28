
#> survisland:modes/pr_stoupy/rats/carry
#
# @executed	as @a[scores={survisland.pr_rats.carried=1..}] & at @s
#
# @within	survisland:modes/pr_stoupy/rats/tick [ as @a[scores={survisland.pr_rats.carried=1..}] & at @s ]
#

scoreboard players operation #pr_rats_id survisland.data = @s survisland.pr_rats.id
execute as @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier] run function survisland:modes/pr_stoupy/rats/carry_one

