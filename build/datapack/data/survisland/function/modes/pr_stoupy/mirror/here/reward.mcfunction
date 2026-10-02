
#> survisland:modes/pr_stoupy/mirror/here/reward
#
# @within	(public)
#

# The session of the nearest reflection, so nothing happens once it is over: its nearest player gets the star, then the session stops
# The anchor stays as won on its start block, which cannot start again until here/clear removes it
execute unless entity @e[type=mannequin,tag=survisland.pr_mirror.body,distance=..24] run return 0
scoreboard players operation #pr_mirror_session survisland.data = @n[type=mannequin,tag=survisland.pr_mirror.body,distance=..24] survisland.pr_mirror.session
execute as @p[tag=survisland.pr_mirror,predicate=survisland:modes/pr_stoupy/mirror/same_session] at @s run function survisland:modes/pr_stoupy/give_star {trial:"Les miroirs"}
tag @e[type=minecraft:marker,tag=survisland.pr_mirror.anchor,predicate=survisland:modes/pr_stoupy/mirror/same_session] add survisland.pr_mirror.done
function survisland:modes/pr_stoupy/mirror/stop_session

