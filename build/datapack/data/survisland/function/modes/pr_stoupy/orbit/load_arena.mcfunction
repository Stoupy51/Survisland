
#> survisland:modes/pr_stoupy/orbit/load_arena
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/orbit/arena_tick
#			survisland:modes/pr_stoupy/orbit/start [ as @n[type=minecraft:marker,tag=survisland.pr_orbit.hole] ]
#			survisland:modes/pr_stoupy/orbit/stop_hole
#

# @s is a hole
scoreboard players operation #pr_orbit_arena survisland.data = @s survisland.pr_orbit.arena
scoreboard players operation #pr_orbit_state survisland.data = @s survisland.pr_orbit.state
scoreboard players operation #pr_orbit_round survisland.data = @s survisland.pr_orbit.round
scoreboard players operation #pr_orbit_banked survisland.data = @s survisland.pr_orbit.banked
scoreboard players operation #pr_orbit_required survisland.data = @s survisland.pr_orbit.required
scoreboard players operation #pr_orbit_pull survisland.data = @s survisland.pr_orbit.pull
scoreboard players operation #pr_orbit_timer survisland.data = @s survisland.pr_orbit.timer
scoreboard players operation #pr_orbit_clock survisland.data = @s survisland.pr_orbit.clock

