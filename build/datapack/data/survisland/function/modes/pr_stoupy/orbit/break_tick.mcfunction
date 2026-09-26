
#> survisland:modes/pr_stoupy/orbit/break_tick
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/orbit/arena_tick
#

scoreboard players remove #pr_orbit_timer survisland.data 1
execute if score #pr_orbit_timer survisland.data matches ..0 run function survisland:modes/pr_stoupy/orbit/next_round

