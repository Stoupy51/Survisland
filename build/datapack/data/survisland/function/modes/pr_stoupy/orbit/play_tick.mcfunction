
#> survisland:modes/pr_stoupy/orbit/play_tick
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/orbit/arena_tick
#

# Run as and at the hole of the arena, whose state is loaded in the fake players
execute as @e[type=minecraft:item_display,tag=survisland.pr_orbit.ring0,tag=!survisland.pr_orbit.stolen,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run function survisland:modes/pr_stoupy/orbit/turn/0
execute as @e[type=minecraft:item_display,tag=survisland.pr_orbit.ring1,tag=!survisland.pr_orbit.stolen,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run function survisland:modes/pr_stoupy/orbit/turn/1
execute as @e[type=minecraft:item_display,tag=survisland.pr_orbit.ring2,tag=!survisland.pr_orbit.stolen,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run function survisland:modes/pr_stoupy/orbit/turn/2
execute as @e[type=minecraft:item_display,tag=survisland.pr_orbit.ring3,tag=!survisland.pr_orbit.stolen,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run function survisland:modes/pr_stoupy/orbit/turn/3
execute as @e[type=minecraft:item_display,tag=survisland.pr_orbit.ring4,tag=!survisland.pr_orbit.stolen,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run function survisland:modes/pr_stoupy/orbit/turn/4
execute as @e[type=minecraft:item_display,tag=survisland.pr_orbit.ring5,tag=!survisland.pr_orbit.stolen,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run function survisland:modes/pr_stoupy/orbit/turn/5
execute as @e[type=minecraft:item_display,tag=survisland.pr_orbit.fragment,tag=!survisland.pr_orbit.stolen,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @s as @p[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,distance=..1.6] run function survisland:modes/pr_stoupy/orbit/pick_up
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.collector,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,scores={survisland.pr_orbit.carried=1..},distance=..3] run function survisland:modes/pr_stoupy/orbit/bank
function survisland:modes/pr_stoupy/orbit/phantoms_tick
# No NBT stops a mob from dropping experience, so the orbs of dead phantoms are removed as they appear
kill @e[type=minecraft:experience_orb,distance=..40]
function survisland:modes/pr_stoupy/orbit/check_round

