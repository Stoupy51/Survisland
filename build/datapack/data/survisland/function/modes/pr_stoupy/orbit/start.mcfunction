
#> survisland:modes/pr_stoupy/orbit/start
#
# @within	(public)
#

# Safe to fire every tick: a player on a start pad joins the room of the nearest hole, the first one starts round 1
tag @a[tag=survisland.pr_stoupy.back,predicate=!survisland:modes/pr_stoupy/on_start_pad] remove survisland.pr_stoupy.back
execute unless entity @a[tag=!survisland.pr_orbit,tag=!survisland.pr_stoupy.back,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,gamemode=!spectator] run return 0
execute unless entity @e[type=minecraft:marker,tag=survisland.pr_orbit.hole] run return run title @a[tag=!survisland.pr_orbit,tag=!survisland.pr_stoupy.back,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,gamemode=!spectator] actionbar {"text":"Orbite : pas de trou noir, le poser avec here/place_black_hole.","color":"red"}
execute if entity @n[type=minecraft:marker,tag=survisland.pr_orbit.hole,tag=survisland.pr_orbit.done] run return fail
execute as @n[type=minecraft:marker,tag=survisland.pr_orbit.hole] run function survisland:modes/pr_stoupy/orbit/load_arena
execute unless entity @e[type=minecraft:marker,tag=survisland.pr_orbit.collector,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run return run title @a[tag=!survisland.pr_orbit,tag=!survisland.pr_stoupy.back,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,gamemode=!spectator] actionbar {"text":"Orbite : pas de collector pour ce trou noir, le poser avec here/set_collector.","color":"red"}

execute as @a[tag=!survisland.pr_orbit,tag=!survisland.pr_stoupy.back,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,gamemode=!spectator] at @s run function survisland:modes/pr_stoupy/orbit/enroll_player
execute if score #pr_orbit_state survisland.data matches 0 run function survisland:modes/pr_stoupy/orbit/begin
execute as @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run function survisland:modes/pr_stoupy/orbit/save_arena
schedule function survisland:modes/pr_stoupy/orbit/tick 1t replace

