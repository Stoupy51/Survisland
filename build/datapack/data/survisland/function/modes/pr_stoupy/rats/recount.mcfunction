
#> survisland:modes/pr_stoupy/rats/recount
#
# @executed	as @a[scores={survisland.pr_rats.carried=1..}]
#
# @within	survisland:modes/pr_stoupy/rats/here/stop [ as @a[scores={survisland.pr_rats.carried=1..}] ]
#

scoreboard players operation #pr_rats_id survisland.data = @s survisland.pr_rats.id
execute store result score @s survisland.pr_rats.carried if entity @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier]

