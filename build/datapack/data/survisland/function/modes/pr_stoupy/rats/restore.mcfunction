
#> survisland:modes/pr_stoupy/rats/restore
#
# @executed	as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new]
#
# @within	survisland:modes/pr_stoupy/rats/release_one [ as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] ]
#

tag @s remove survisland.pr_rats.new
tag @s add survisland.pr_rats.released
execute on passengers run data modify entity @s item set from storage survisland:pr_rats item
function survisland:modes/pr_stoupy/rats/apply_size

