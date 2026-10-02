
#> survisland:modes/pr_stoupy/duo/here/reward
#
# @within	(public)
#

# One shot at the exit, once the redstone puzzle is solved: the nearest player gets the star
execute as @p[distance=..5,gamemode=!spectator] run function survisland:modes/pr_stoupy/give_star {trial:"Les duos"}
execute if entity @p[distance=..5,gamemode=!spectator] summon minecraft:marker run function survisland:modes/pr_stoupy/duo/lock

