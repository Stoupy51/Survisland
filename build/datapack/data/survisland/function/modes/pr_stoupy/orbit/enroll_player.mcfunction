
#> survisland:modes/pr_stoupy/orbit/enroll_player
#
# @executed	as @a[tag=!survisland.pr_orbit,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,limit=4,sort=nearest]
#
# @within	survisland:modes/pr_stoupy/orbit/start [ as @a[tag=!survisland.pr_orbit,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,limit=4,sort=nearest] ]
#

tag @s add survisland.pr_orbit
scoreboard players operation @s survisland.pr_orbit.arena = #pr_orbit_arena survisland.data
scoreboard players set @s survisland.pr_orbit.carried 0
attribute @s minecraft:gravity base set 0.05
attribute @s minecraft:fall_damage_multiplier base set 0
give @s minecraft:iron_sword[custom_data={survisland:{orbit_sword:true}},item_name={"text":"Épée stellaire","color":"aqua"}]
tp @s @e[type=minecraft:marker,tag=survisland.pr_orbit.spawn,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1]

