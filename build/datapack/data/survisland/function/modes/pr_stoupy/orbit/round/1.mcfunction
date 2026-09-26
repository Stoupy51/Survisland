
#> survisland:modes/pr_stoupy/orbit/round/1
#
# @within	survisland:modes/pr_stoupy/orbit/next_round
#

scoreboard players set #pr_orbit_required survisland.data 6
scoreboard players set #pr_orbit_pull survisland.data 1000
scoreboard players set #pr_orbit_inner_pull survisland.data 1600
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:0}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:1,angle:60}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:2,angle:120}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:180}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:1,angle:240}
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:2,angle:300}

title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] times 10 50 10
title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] subtitle {"text": "6 fragments à ramener", "color": "#01FE41"}
title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] title {"text": "Round 1/3", "color": "#01FE41"}
execute as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @s run playsound minecraft:block.beacon.power_select master @s

