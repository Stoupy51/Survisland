
#> survisland:modes/pr_stoupy/orbit/pull
#
# @executed	as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] & at @s
#
# @within	survisland:modes/pr_stoupy/orbit/play_tick [ as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] & at @s ]
#

# @s is a player, launched toward the hole, harder once within 12 blocks of it
scoreboard players operation $strength player_motion.api.launch = #pr_orbit_pull survisland.data
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] if entity @s[distance=..12] run scoreboard players operation $strength player_motion.api.launch = #pr_orbit_inner_pull survisland.data
execute facing entity @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] feet run function player_motion:api/launch_looking

