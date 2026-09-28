
#> survisland:modes/pr_stoupy/orbit/stop_arena
#
# @within	survisland:modes/pr_stoupy/orbit/victory
#			survisland:modes/pr_stoupy/orbit/stop_hole
#

# The arena loaded in the fake players goes back to rest
kill @e[type=minecraft:item_display,tag=survisland.pr_orbit.fragment,predicate=survisland:modes/pr_stoupy/orbit/same_arena]
execute as @e[type=minecraft:phantom,tag=survisland.pr_orbit.phantom,predicate=survisland:modes/pr_stoupy/orbit/same_arena] run tp @s ~ -1000 ~
kill @e[type=minecraft:phantom,tag=survisland.pr_orbit.phantom,predicate=survisland:modes/pr_stoupy/orbit/same_arena]
execute as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] run attribute @s minecraft:gravity base reset
execute as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] run attribute @s minecraft:fall_damage_multiplier base reset
clear @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] *[custom_data~{survisland:{orbit_sword:true}}]
tag @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] remove survisland.pr_orbit
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.pad,predicate=survisland:modes/pr_stoupy/orbit/same_arena] run setblock ~ ~ ~ minecraft:emerald_block
kill @e[type=minecraft:marker,tag=survisland.pr_orbit.pad,predicate=survisland:modes/pr_stoupy/orbit/same_arena]
scoreboard players set #pr_orbit_state survisland.data 0

