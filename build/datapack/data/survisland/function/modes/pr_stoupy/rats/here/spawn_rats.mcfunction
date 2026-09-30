
#> survisland:modes/pr_stoupy/rats/here/spawn_rats
#
# @within	???
#
# @args		goal (unknown)
#			count (unknown)
#			radius (unknown)
#

# $(count) rats of random variants, spread on the ground within $(radius) blocks, never above three blocks over this one
# $(goal) of them to cage for the star, 0 for all of them
execute unless entity @e[type=minecraft:interaction,tag=survisland.pr_rats.collector] run return run tellraw @a[distance=..16] {"text":"Rats : place d'abord le collecteur (here/place_collector).","color":"red"}
$scoreboard players set @n[type=minecraft:interaction,tag=survisland.pr_rats.collector] survisland.pr_rats.goal $(goal)
$scoreboard players set #pr_rats_to_spawn survisland.data $(count)
$data modify storage survisland:pr_rats spread.radius set value $(radius)
function survisland:modes/pr_stoupy/rats/spawn_loop
execute summon minecraft:marker run function survisland:modes/pr_stoupy/rats/spread_height
function survisland:modes/pr_stoupy/rats/spread with storage survisland:pr_rats spread

