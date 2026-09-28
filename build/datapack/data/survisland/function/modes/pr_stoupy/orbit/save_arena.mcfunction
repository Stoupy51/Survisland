
#> survisland:modes/pr_stoupy/orbit/save_arena
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/orbit/arena_tick
#			survisland:modes/pr_stoupy/orbit/start [ as @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] ]
#			survisland:modes/pr_stoupy/orbit/stop_hole
#

# @s is a hole
scoreboard players operation @s survisland.pr_orbit.arena = #pr_orbit_arena survisland.data
scoreboard players operation @s survisland.pr_orbit.state = #pr_orbit_state survisland.data
scoreboard players operation @s survisland.pr_orbit.round = #pr_orbit_round survisland.data
scoreboard players operation @s survisland.pr_orbit.banked = #pr_orbit_banked survisland.data
scoreboard players operation @s survisland.pr_orbit.required = #pr_orbit_required survisland.data
scoreboard players operation @s survisland.pr_orbit.pull = #pr_orbit_pull survisland.data
scoreboard players operation @s survisland.pr_orbit.timer = #pr_orbit_timer survisland.data
scoreboard players operation @s survisland.pr_orbit.clock = #pr_orbit_clock survisland.data

