
#> survisland:modes/pr_stoupy/duo/here/reward
#
# @within	(public)
#

# The room of the nearest mannequin, so nothing happens once it is over: its nearest player gets the star and locks its start,
# then every pair of the room gets its body back on its start pad
execute unless entity @e[type=mannequin,tag=survisland.pr_stoupy_duo.body,distance=..24] run return 0
scoreboard players operation #pr_stoupy_duo_room survisland.data = @n[type=mannequin,tag=survisland.pr_stoupy_duo.body,distance=..24] survisland.pr_stoupy_duo.room
execute as @p[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_room] at @s run function survisland:modes/pr_stoupy/give_star {trial:"Les duos"}
execute summon minecraft:marker run function survisland:modes/pr_stoupy/duo/lock
execute as @e[type=mannequin,tag=survisland.pr_stoupy_duo.body,predicate=survisland:modes/pr_stoupy/duo/same_room] at @s run function survisland:modes/pr_stoupy/duo/body/stop

