
#> survisland:modes/pr_stoupy/orbit/swallowed
#
# @within	survisland:modes/pr_stoupy/orbit/swallow
#

# Back above the hole marker, and every fragment carried goes back to orbit
execute if score @s survisland.pr_orbit.carried matches 1.. at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:97}
execute if score @s survisland.pr_orbit.carried matches 2.. at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:1,angle:194}
execute if score @s survisland.pr_orbit.carried matches 3.. at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:2,angle:291}
execute if score @s survisland.pr_orbit.carried matches 4.. at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:28}
execute if score @s survisland.pr_orbit.carried matches 5.. at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:1,angle:125}
execute if score @s survisland.pr_orbit.carried matches 6.. at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:2,angle:222}
execute if score @s survisland.pr_orbit.carried matches 7.. at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:319}
execute if score @s survisland.pr_orbit.carried matches 8.. at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:1,angle:56}
execute if score @s survisland.pr_orbit.carried matches 9.. at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:2,angle:153}
execute if score @s survisland.pr_orbit.carried matches 10.. at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] summon minecraft:item_display run function survisland:modes/pr_stoupy/orbit/new_fragment {ring:0,angle:250}
scoreboard players set @s survisland.pr_orbit.carried 0
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run tp @s ~ ~1 ~
effect give @s minecraft:blindness 2 0 true
playsound minecraft:entity.enderman.teleport ambient @s ~ ~ ~ 1 0.5
tellraw @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] [{"selector":"@s","color":"aqua"},{"text":" a été avalé par le trou noir !","color":"#01FE41"}]

