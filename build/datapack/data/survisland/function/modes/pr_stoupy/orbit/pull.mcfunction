
#> survisland:modes/pr_stoupy/orbit/pull
#
# @executed	as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] & at @s
#
# @within	survisland:modes/pr_stoupy/orbit/push_tick [ as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] & at @s ]
#

# @s is a player, launched along the facing of the hole marker
scoreboard players operation $strength player_motion.api.launch = #pr_orbit_pull survisland.data
execute rotated as @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run function player_motion:api/launch_looking

