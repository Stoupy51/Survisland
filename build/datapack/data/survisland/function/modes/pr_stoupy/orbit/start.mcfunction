
#> survisland:modes/pr_stoupy/orbit/start
#
# @within	???
#

# Safe to fire every tick: the room of the nearest hole starts once idle, fully placed, with enough free players here
execute unless entity @e[type=minecraft:marker,tag=survisland.pr_orbit.hole] run return 0
execute if score @n[type=minecraft:marker,tag=survisland.pr_orbit.hole] survisland.pr_orbit.state matches 1.. run return 0
execute store result score #pr_orbit_free survisland.data if entity @a[tag=!survisland.pr_orbit,distance=..6,gamemode=!creative,gamemode=!spectator]
execute if score #pr_orbit_free survisland.data matches ..1 run return 0
execute as @n[type=minecraft:marker,tag=survisland.pr_orbit.hole] run function survisland:modes/pr_stoupy/orbit/load_arena
execute unless entity @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run return 0
execute unless entity @e[type=minecraft:marker,tag=survisland.pr_orbit.collector,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run return 0
execute unless entity @e[type=minecraft:marker,tag=survisland.pr_orbit.spawn,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run return 0

execute as @a[tag=!survisland.pr_orbit,distance=..6,gamemode=!creative,gamemode=!spectator,limit=4,sort=nearest] run function survisland:modes/pr_stoupy/orbit/enroll_player
scoreboard players set #pr_orbit_round survisland.data 0
scoreboard players set #pr_orbit_clock survisland.data 0
function survisland:modes/pr_stoupy/orbit/next_round
execute as @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] run function survisland:modes/pr_stoupy/orbit/save_arena
schedule function survisland:modes/pr_stoupy/orbit/tick 1t replace

