
#> survisland:modes/pr_stoupy/orbit/phantom_hit
#
# @executed	as the player & at current position
#
# @within	advancement survisland:modes/pr_stoupy/orbit_phantom_hit
#

advancement revoke @s only survisland:modes/pr_stoupy/orbit_phantom_hit
scoreboard players operation #pr_orbit_arena survisland.data = @s survisland.pr_orbit.arena
scoreboard players set $strength player_motion.api.launch 6000
execute at @s facing entity @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] feet run function player_motion:api/launch_looking

