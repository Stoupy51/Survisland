
#> survisland:modes/pr_stoupy/orbit/round/3
#
# @within	survisland:modes/pr_stoupy/orbit/next_round
#

scoreboard players set #pr_orbit_required survisland.data 10
scoreboard players set #pr_orbit_pull survisland.data 1800
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:0}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:1,angle:36}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:2,angle:72}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:108}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:1,angle:144}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:2,angle:180}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:216}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:1,angle:252}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:2,angle:288}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:324}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] positioned ~ ~8 ~ summon minecraft:phantom run function survisland:modes/pr_stoupy/orbit/new_phantom
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] positioned ~ ~8 ~ summon minecraft:phantom run function survisland:modes/pr_stoupy/orbit/new_phantom
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] positioned ~ ~8 ~ summon minecraft:phantom run function survisland:modes/pr_stoupy/orbit/new_phantom
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] positioned ~ ~8 ~ summon minecraft:phantom run function survisland:modes/pr_stoupy/orbit/new_thief
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] positioned ~ ~8 ~ summon minecraft:phantom run function survisland:modes/pr_stoupy/orbit/new_thief
title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] times 10 50 10
title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] subtitle {"text": "10 fragments à ramener, 5 phantoms à abattre", "color": "#01FE41"}
title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] title {"text": "Round 3/3", "color": "#01FE41"}
execute as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @s run playsound minecraft:block.beacon.power_select master @s

