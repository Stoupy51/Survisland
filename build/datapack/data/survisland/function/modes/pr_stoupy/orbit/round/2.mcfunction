
#> survisland:modes/pr_stoupy/orbit/round/2
#
# @within	survisland:modes/pr_stoupy/orbit/next_round
#

scoreboard players set #pr_orbit_required survisland.data 8
scoreboard players set #pr_orbit_pull survisland.data 1400
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:0}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:1,angle:45}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:2,angle:90}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:135}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:1,angle:180}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:2,angle:225}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:270}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:1,angle:315}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] positioned ~ ~8 ~ summon minecraft:phantom run function survisland:modes/pr_stoupy/orbit/new_phantom
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] positioned ~ ~8 ~ summon minecraft:phantom run function survisland:modes/pr_stoupy/orbit/new_phantom
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] positioned ~ ~8 ~ summon minecraft:phantom run function survisland:modes/pr_stoupy/orbit/new_phantom
title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] times 10 50 10
title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] subtitle {"text": "8 fragments à ramener, 3 phantoms à abattre", "color": "#01FE41"}
title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] title {"text": "Round 2/3", "color": "#01FE41"}
execute as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @s run playsound minecraft:block.beacon.power_select master @s

