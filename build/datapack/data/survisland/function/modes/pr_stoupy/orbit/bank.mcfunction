
#> survisland:modes/pr_stoupy/orbit/bank
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_orbit.collector,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] & as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,scores={survisland.pr_orbit.carried=1..},distance=..3]
#
# @within	survisland:modes/pr_stoupy/orbit/play_tick [ at @e[type=minecraft:marker,tag=survisland.pr_orbit.collector,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] & as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,scores={survisland.pr_orbit.carried=1..},distance=..3] ]
#

scoreboard players operation #pr_orbit_banked survisland.data += @s survisland.pr_orbit.carried
scoreboard players set @s survisland.pr_orbit.carried 0
playsound minecraft:block.beacon.power_select master @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] ~ ~ ~ 1 1.6
particle minecraft:end_rod ~ ~1 ~ 0.4 0.8 0.4 0.05 40

