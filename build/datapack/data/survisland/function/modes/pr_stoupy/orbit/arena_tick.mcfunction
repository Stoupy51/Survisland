
#> survisland:modes/pr_stoupy/orbit/arena_tick
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/orbit/tick [ at @s ]
#

# State: 1 round in play, 2 break between two rounds, 0 stopped
execute unless score @s survisland.pr_orbit.state matches 1..2 run return 0
function survisland:modes/pr_stoupy/orbit/load_arena
execute if score #pr_orbit_state survisland.data matches 1 run function survisland:modes/pr_stoupy/orbit/play_tick
execute if score #pr_orbit_state survisland.data matches 2 run function survisland:modes/pr_stoupy/orbit/break_tick
execute if score #pr_orbit_state survisland.data matches 1..2 run scoreboard players add #pr_orbit_active survisland.data 1
function survisland:modes/pr_stoupy/orbit/save_arena

