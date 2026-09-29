
#> survisland:modes/pr_stoupy/orbit/victory
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/orbit/check_round
#

execute as @r[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @s run function survisland:modes/pr_stoupy/give_star {trial:"L'orbite"}
function survisland:modes/pr_stoupy/orbit/stop_arena

