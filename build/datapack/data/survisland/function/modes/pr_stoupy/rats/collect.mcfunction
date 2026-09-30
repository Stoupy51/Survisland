
#> survisland:modes/pr_stoupy/rats/collect
#
# @executed	as the player & at current position
#
# @within	advancement survisland:modes/pr_stoupy/rats_hit_collector
#			advancement survisland:modes/pr_stoupy/rats_use_collector
#

# @s clicked the collector of its arena: its rats run free again in the cage
advancement revoke @s only survisland:modes/pr_stoupy/rats_hit_collector
advancement revoke @s only survisland:modes/pr_stoupy/rats_use_collector
execute unless score @s survisland.pr_rats.carried matches 1.. run return run title @s actionbar {"text":"Frappe des rats pour les attraper, puis reviens ici.","color":"red"}
scoreboard players operation #pr_rats_arena survisland.data = @n[type=minecraft:interaction,tag=survisland.pr_rats.collector] survisland.pr_rats.arena
execute unless entity @e[type=minecraft:marker,tag=survisland.pr_rats.cage,predicate=survisland:modes/pr_stoupy/rats/same_arena] run return run title @s actionbar {"text":"Ce collecteur n'a pas de cage (here/place_cage).","color":"red"}
scoreboard players operation #pr_rats_id survisland.data = @s survisland.pr_rats.id
execute at @n[type=minecraft:marker,tag=survisland.pr_rats.cage,predicate=survisland:modes/pr_stoupy/rats/same_arena] as @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier] run function survisland:modes/pr_stoupy/rats/release_one
tag @e[type=minecraft:ocelot,tag=survisland.pr_rats.released] add survisland.pr_rats.caged
tag @e[type=minecraft:ocelot,tag=survisland.pr_rats.released] remove survisland.pr_rats.released
scoreboard players set @s survisland.pr_rats.carried 0
playsound minecraft:block.iron_door.close block @a[distance=..16] ~ ~ ~ 1 1.2

execute store result score #pr_rats_caged survisland.data if entity @e[type=minecraft:ocelot,tag=survisland.pr_rats.caged,predicate=survisland:modes/pr_stoupy/rats/same_arena]
scoreboard players operation #pr_rats_goal survisland.data = @n[type=minecraft:interaction,tag=survisland.pr_rats.collector,predicate=survisland:modes/pr_stoupy/rats/same_arena] survisland.pr_rats.goal
execute if score #pr_rats_goal survisland.data matches 1.. run title @a[distance=..16] actionbar [{"text":"Rats en cage : ","color":"gray"},{"score":{"name":"#pr_rats_caged","objective":"survisland.data"},"color":"aqua"},{"text":"/","color":"aqua"},{"score":{"name":"#pr_rats_goal","objective":"survisland.data"},"color":"aqua"}]
execute if score #pr_rats_goal survisland.data matches 0 run title @a[distance=..16] actionbar [{"text":"Rats en cage : ","color":"gray"},{"score":{"name":"#pr_rats_caged","objective":"survisland.data"},"color":"aqua"}]
execute if score #pr_rats_goal survisland.data matches 1.. if score #pr_rats_caged survisland.data >= #pr_rats_goal survisland.data run return run function survisland:modes/pr_stoupy/rats/victory
execute unless entity @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat,tag=!survisland.pr_rats.caged,predicate=survisland:modes/pr_stoupy/rats/same_arena] unless entity @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_arena] run function survisland:modes/pr_stoupy/rats/victory

