
#> survisland:modes/pr_stoupy/orbit/new_marker
#
# @executed	align xyz & positioned ~0.5 ~ ~0.5
#
# @within	survisland:modes/pr_stoupy/orbit/here/set_orbit {name:"orbit"} [ align xyz & positioned ~0.5 ~ ~0.5 ]
#			survisland:modes/pr_stoupy/orbit/here/set_collector {name:"collector"} [ align xyz & positioned ~0.5 ~ ~0.5 ]
#			survisland:modes/pr_stoupy/orbit/here/set_spawn {name:"spawn"} [ align xyz & positioned ~0.5 ~ ~0.5 ]
#
# @args		name (string)
#

$tag @s add survisland.pr_orbit.$(name)
scoreboard players operation @s survisland.pr_orbit.arena = #pr_orbit_arena survisland.data

