
#> survisland:modes/pr_stoupy/rats/here/spawn_rats
#
# @within	???
#
# @args		count (unknown)
#			radius (unknown)
#

# $(count) rats of random variants, spread on the ground within $(radius) blocks, never above three blocks over this one
$scoreboard players set #pr_rats_to_spawn survisland.data $(count)
$data modify storage survisland:pr_rats spread.radius set value $(radius)
function survisland:modes/pr_stoupy/rats/spawn_loop
execute summon minecraft:marker run function survisland:modes/pr_stoupy/rats/spread_height
function survisland:modes/pr_stoupy/rats/spread with storage survisland:pr_rats spread

