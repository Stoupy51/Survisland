
#> survisland:modes/pr_stoupy/duo/body/remount
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/body/tick
#			survisland:modes/pr_stoupy/duo/body/enter_phase/laboratoire
#

# The only pass still scanning the players, and it only runs while someone is off its vehicle
execute as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] run function survisland:modes/pr_stoupy/duo/body/mount_player

# Still short, so someone was left behind by a teleport: the whole player list is searched this time
execute if score #pr_stoupy_duo_crew survisland.data matches ..1 as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group] run function survisland:modes/pr_stoupy/duo/body/mount_player

