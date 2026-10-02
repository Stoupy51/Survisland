
#> survisland:modes/pr_stoupy/duo/lock
#
# @within	survisland:modes/pr_stoupy/duo/here/reward
#

# Moved where the start took the winner from, which locks that start until here/clear
tag @s add survisland.pr_stoupy_duo.done
execute store result entity @s Pos[0] double 0.01 run scoreboard players get @p[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_room] survisland.pr_stoupy.x
execute store result entity @s Pos[1] double 0.01 run scoreboard players get @p[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_room] survisland.pr_stoupy.y
execute store result entity @s Pos[2] double 0.01 run scoreboard players get @p[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_room] survisland.pr_stoupy.z

