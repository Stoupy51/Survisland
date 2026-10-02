
#> survisland:modes/pr_stoupy/mirror/here/reward
#
# @within	(public)
#

# One shot at the exit: the nearest player gets the star, then the reflections of its session go away
# The anchor stays as won on its start block, which cannot start again until here/clear removes it
execute as @p[distance=..5,gamemode=!spectator] run function survisland:modes/pr_stoupy/give_star {trial:"Les miroirs"}
execute unless entity @p[tag=survisland.pr_mirror,distance=..5] run return 0
scoreboard players operation #pr_mirror_session survisland.data = @p[tag=survisland.pr_mirror,distance=..5] survisland.pr_mirror.session
tag @e[type=minecraft:marker,tag=survisland.pr_mirror.anchor,predicate=survisland:modes/pr_stoupy/mirror/same_session] add survisland.pr_mirror.done
function survisland:modes/pr_stoupy/mirror/stop_session

