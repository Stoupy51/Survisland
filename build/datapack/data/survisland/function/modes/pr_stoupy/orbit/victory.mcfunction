
#> survisland:modes/pr_stoupy/orbit/victory
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/orbit/check_round
#

# The hole keeps the win, so its room cannot be played again until the hole is placed anew
tag @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] add survisland.pr_orbit.done
execute as @r[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @s run function survisland:modes/pr_stoupy/give_star {trial:"L'orbite"}
function survisland:modes/pr_stoupy/orbit/stop_arena

