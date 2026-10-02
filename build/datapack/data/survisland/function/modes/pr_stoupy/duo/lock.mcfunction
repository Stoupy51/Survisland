
#> survisland:modes/pr_stoupy/duo/lock
#
# @within	survisland:modes/pr_stoupy/duo/here/reward
#

# Run at the reward block, so @p is the winner: the marker goes where its start took it from and locks that start until here/clear
tag @s add survisland.pr_stoupy_duo.done
execute store result entity @s Pos[0] double 0.01 run scoreboard players get @p[gamemode=!spectator] survisland.pr_stoupy.x
execute store result entity @s Pos[1] double 0.01 run scoreboard players get @p[gamemode=!spectator] survisland.pr_stoupy.y
execute store result entity @s Pos[2] double 0.01 run scoreboard players get @p[gamemode=!spectator] survisland.pr_stoupy.z

