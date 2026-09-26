
#> survisland:modes/pr_stoupy/orbit/new_hole
#
# @executed	align xyz & positioned ~0.5 ~ ~0.5
#
# @within	survisland:modes/pr_stoupy/orbit/here/set_hole [ align xyz & positioned ~0.5 ~ ~0.5 ]
#

tag @s add survisland.pr_orbit.hole
scoreboard players set #pr_orbit_state survisland.data 0
scoreboard players operation @s survisland.pr_orbit.arena = #pr_orbit_arena survisland.data
scoreboard players operation @s survisland.pr_orbit.state = #pr_orbit_state survisland.data
scoreboard players operation @s survisland.pr_orbit.round = #pr_orbit_round survisland.data
scoreboard players operation @s survisland.pr_orbit.banked = #pr_orbit_banked survisland.data
scoreboard players operation @s survisland.pr_orbit.required = #pr_orbit_required survisland.data
scoreboard players operation @s survisland.pr_orbit.pull = #pr_orbit_pull survisland.data
scoreboard players operation @s survisland.pr_orbit.inner_pull = #pr_orbit_inner_pull survisland.data
scoreboard players operation @s survisland.pr_orbit.timer = #pr_orbit_timer survisland.data
scoreboard players operation @s survisland.pr_orbit.clock = #pr_orbit_clock survisland.data

