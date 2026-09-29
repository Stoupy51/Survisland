
#> survisland:modes/pr_stoupy/orbit/here/set_collector
#
# @within	???
#

# Joins the arena of the nearest hole, which must be placed first, with a glowing star and a label showing it from afar
execute unless entity @e[type=minecraft:marker,tag=survisland.pr_orbit.hole] run return run tellraw @a[distance=..16] {"text":"Orbite : place d'abord le trou noir (here/place_black_hole).","color":"red"}
scoreboard players operation #pr_orbit_arena survisland.data = @n[type=minecraft:marker,tag=survisland.pr_orbit.hole] survisland.pr_orbit.arena
kill @e[tag=survisland.pr_orbit.collector,predicate=survisland:modes/pr_stoupy/orbit/same_arena]
execute align xyz positioned ~0.5 ~ ~0.5 run function survisland:modes/pr_stoupy/orbit/place_collector
tellraw @a[distance=..16] {"text":"Orbite : collector placé (où les fragments sont déposés).","color":"green"}

