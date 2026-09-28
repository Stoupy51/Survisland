
#> survisland:modes/pr_stoupy/orbit/next_round
#
# @within	survisland:modes/pr_stoupy/orbit/begin
#			survisland:modes/pr_stoupy/orbit/break_tick
#

scoreboard players add #pr_orbit_round survisland.data 1
execute if score #pr_orbit_round survisland.data matches 4.. run return run function survisland:modes/pr_stoupy/orbit/victory
scoreboard players set #pr_orbit_state survisland.data 1
scoreboard players set #pr_orbit_banked survisland.data 0
execute if score #pr_orbit_round survisland.data matches 1 run function survisland:modes/pr_stoupy/orbit/round/1
execute if score #pr_orbit_round survisland.data matches 2 run function survisland:modes/pr_stoupy/orbit/round/2
execute if score #pr_orbit_round survisland.data matches 3 run function survisland:modes/pr_stoupy/orbit/round/3

