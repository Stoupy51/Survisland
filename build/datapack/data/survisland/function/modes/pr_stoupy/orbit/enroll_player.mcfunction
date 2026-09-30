
#> survisland:modes/pr_stoupy/orbit/enroll_player
#
# @executed	as @a[tag=!...,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative] & at @s
#
# @within	survisland:modes/pr_stoupy/orbit/start [ as @a[tag=!...,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative] & at @s ]
#

function survisland:modes/pr_stoupy/rats/release
tag @s add survisland.pr_orbit
scoreboard players operation @s survisland.pr_orbit.arena = #pr_orbit_arena survisland.data
scoreboard players set @s survisland.pr_orbit.carried 0
attribute @s minecraft:gravity base set 0.01
attribute @s minecraft:fall_damage_multiplier base set 0
# Phantoms still shove the player toward the hole, but a death would leave it tagged and pushed wherever it respawns
effect give @s minecraft:resistance infinite 4 true
give @s minecraft:iron_sword[custom_data={survisland:{orbit_sword:true}},item_name={"text":"Épée stellaire","color":"aqua"}]
function survisland:modes/pr_stoupy/orbit/find_pad
execute at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run tp @s ~ ~1 ~

