
#> survisland:modes/pr_stoupy/rats/drop_in_cage
#
# @executed	at @s & as @a[scores={survisland.pr_rats.carried=1..},distance=..2.5]
#
# @within	survisland:modes/pr_stoupy/rats/tick [ at @s & as @a[scores={survisland.pr_rats.carried=1..},distance=..2.5] ]
#

# Positioned on the cage, @s is a player carrying rats: they join the arena of the cage and fill its next slots
scoreboard players operation #pr_rats_id survisland.data = @s survisland.pr_rats.id
scoreboard players operation #pr_rats_arena survisland.data = @n[type=minecraft:marker,tag=survisland.pr_rats.cage,distance=..0.1] survisland.pr_rats.arena
scoreboard players operation #pr_rats_caged survisland.data = @n[type=minecraft:marker,tag=survisland.pr_rats.cage,distance=..0.1] survisland.pr_rats.caged
execute as @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier] run function survisland:modes/pr_stoupy/rats/cage_one
scoreboard players operation @n[type=minecraft:marker,tag=survisland.pr_rats.cage,distance=..0.1] survisland.pr_rats.caged = #pr_rats_caged survisland.data
scoreboard players set @s survisland.pr_rats.carried 0
playsound minecraft:block.iron_door.close block @a[distance=..16] ~ ~ ~ 1 1.2
execute unless entity @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat,predicate=survisland:modes/pr_stoupy/rats/same_arena] unless entity @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_arena] run function survisland:modes/pr_stoupy/rats/victory

