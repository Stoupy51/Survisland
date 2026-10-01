
#> survisland:modes/pr_stoupy/rats/here/place_cage
#
# @within	(public)
#

# Replaces the cage of the arena of the nearest collector, the rats dropped there are let loose on this block
execute unless entity @e[type=minecraft:interaction,tag=survisland.pr_rats.collector] run return run tellraw @a[distance=..16] {"text":"Rats : place d'abord le collecteur (here/place_collector).","color":"red"}
scoreboard players operation #pr_rats_arena survisland.data = @n[type=minecraft:interaction,tag=survisland.pr_rats.collector] survisland.pr_rats.arena
kill @e[type=minecraft:marker,tag=survisland.pr_rats.cage,predicate=survisland:modes/pr_stoupy/rats/same_arena]
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function survisland:modes/pr_stoupy/rats/new_cage
tellraw @a[distance=..16] {"text":"Rats : cage placée.","color":"green"}

