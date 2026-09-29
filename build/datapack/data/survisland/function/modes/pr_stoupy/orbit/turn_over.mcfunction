
#> survisland:modes/pr_stoupy/orbit/turn_over
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1]
#
# @within	survisland:modes/pr_stoupy/orbit/turn/1
#			survisland:modes/pr_stoupy/orbit/turn/2
#

execute rotated as @s run rotate @s ~180 ~
execute if entity @s[tag=survisland.pr_orbit.half1] run return run tag @s remove survisland.pr_orbit.half1
tag @s add survisland.pr_orbit.half1

