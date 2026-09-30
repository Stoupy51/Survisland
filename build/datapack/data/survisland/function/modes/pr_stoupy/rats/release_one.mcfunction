
#> survisland:modes/pr_stoupy/rats/release_one
#
# @executed	at @n[type=minecraft:marker,tag=survisland.pr_rats.cage,predicate=survisland:modes/pr_stoupy/rats/same_arena] & as @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier]
#
# @within	survisland:modes/pr_stoupy/rats/collect [ at @n[type=minecraft:marker,tag=survisland.pr_rats.cage,predicate=survisland:modes/pr_stoupy/rats/same_arena] & as @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier] ]
#			survisland:modes/pr_stoupy/rats/release [ as @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier] ]
#

# @s is a carried display: the rat it shows comes back to life here, tagged survisland.pr_rats.released for the caller
scoreboard players operation #pr_rats_variant survisland.data = @s survisland.pr_rats.variant
data modify storage survisland:pr_rats item set from entity @s item
execute if score #pr_rats_variant survisland.data matches 0 run function survisland:modes/pr_stoupy/rats/summon/grey
execute if score #pr_rats_variant survisland.data matches 1 run function survisland:modes/pr_stoupy/rats/summon/white
execute if score #pr_rats_variant survisland.data matches 2 run function survisland:modes/pr_stoupy/rats/summon/brown
execute if score #pr_rats_variant survisland.data matches 3 run function survisland:modes/pr_stoupy/rats/summon/mutant
scoreboard players operation @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] survisland.pr_rats.arena = @s survisland.pr_rats.arena
scoreboard players operation @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] survisland.pr_rats.size = @s survisland.pr_rats.size
execute as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] run function survisland:modes/pr_stoupy/rats/restore
kill @s

