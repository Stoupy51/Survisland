
#> survisland:modes/pr_stoupy/orbit/phantoms_tick
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/orbit/play_tick
#

# A thief without loot tries to steal every 200 ticks, a thief with loot dives toward the hole
scoreboard players operation #pr_orbit_step survisland.data = #pr_orbit_clock survisland.data
scoreboard players operation #pr_orbit_step survisland.data %= #200 survisland.data
execute if score #pr_orbit_step survisland.data matches 0 as @e[type=minecraft:phantom,tag=survisland.pr_orbit.thief,tag=!survisland.pr_orbit.diving,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1,sort=random] run function survisland:modes/pr_stoupy/orbit/steal
execute as @e[type=minecraft:phantom,tag=survisland.pr_orbit.diving,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @s rotated as @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run function survisland:modes/pr_stoupy/orbit/dive

# The fragment of a thief killed on the way falls back into orbit
execute as @e[type=minecraft:item_display,tag=survisland.pr_orbit.stolen,predicate=survisland:modes/pr_stoupy/orbit/same_arena] unless predicate survisland:riding run tag @s remove survisland.pr_orbit.stolen

