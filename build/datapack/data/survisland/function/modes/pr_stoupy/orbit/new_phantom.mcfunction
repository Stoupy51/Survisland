
#> survisland:modes/pr_stoupy/orbit/new_phantom
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] & positioned ~ ~8 ~
#
# @within	survisland:modes/pr_stoupy/orbit/round/2 [ at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] & positioned ~ ~8 ~ ]
#			survisland:modes/pr_stoupy/orbit/round/3 [ at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] & positioned ~ ~8 ~ ]
#			survisland:modes/pr_stoupy/orbit/new_thief
#

tag @s add survisland.pr_orbit.phantom
scoreboard players operation @s survisland.pr_orbit.arena = #pr_orbit_arena survisland.data
data merge entity @s {PersistenceRequired:1b,size:2,active_effects:[{id:"minecraft:fire_resistance",duration:-1,amplifier:0b,show_particles:0b}]}

