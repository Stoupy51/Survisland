
#> survisland:modes/pr_stoupy/rats/resize
#
# @executed	as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new]
#
# @within	survisland:modes/pr_stoupy/rats/here/place_rat [ as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] ]
#			survisland:modes/pr_stoupy/rats/spawn_loop [ as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] ]
#

# A new rat of the nearest arena, with a random size in 75..125 % and a random hat
tag @s remove survisland.pr_rats.new
scoreboard players operation @s survisland.pr_rats.arena = @n[type=minecraft:interaction,tag=survisland.pr_rats.collector] survisland.pr_rats.arena
execute store result score @s survisland.pr_rats.size run random value 75..125
execute store result score #pr_rats_hat survisland.data run random value 0..4
execute on passengers run function survisland:modes/pr_stoupy/rats/pick_hat
function survisland:modes/pr_stoupy/rats/apply_size

