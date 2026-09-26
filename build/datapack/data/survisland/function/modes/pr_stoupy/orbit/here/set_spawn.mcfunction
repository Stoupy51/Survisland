
#> survisland:modes/pr_stoupy/orbit/here/set_spawn
#
# @within	???
#

# Joins the arena of the nearest hole, which must be placed first
execute unless entity @e[type=minecraft:marker,tag=survisland.pr_orbit.hole] run return run tellraw @a[distance=..16] {"text":"Orbite : place d'abord le trou noir (here/set_hole).","color":"red"}
scoreboard players operation #pr_orbit_arena survisland.data = @n[type=minecraft:marker,tag=survisland.pr_orbit.hole] survisland.pr_orbit.arena
kill @e[type=minecraft:marker,tag=survisland.pr_orbit.spawn,predicate=survisland:modes/pr_stoupy/orbit/same_arena]
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function survisland:modes/pr_stoupy/orbit/new_marker {name:"spawn"}
tellraw @a[distance=..16] {"text":"Orbite : spawn placé (départ et retour des joueurs avalés).","color":"green"}

