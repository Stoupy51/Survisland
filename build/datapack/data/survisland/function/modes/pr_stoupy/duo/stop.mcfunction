
#> survisland:modes/pr_stoupy/duo/stop
#
# @within	???
#

# Stop every group still running
execute as @e[type=mannequin,tag=survisland.pr_stoupy_duo.body] at @s run function survisland:modes/pr_stoupy/duo/body/stop
kill @e[type=mannequin,tag=survisland.pr_stoupy_duo.body]
kill @e[type=item_display,tag=survisland.pr_stoupy_duo.seat]

# Catch anyone who ended up out of range of their body
execute as @a[tag=survisland.pr_stoupy_duo] run function survisland:modes/pr_stoupy/duo/body/release_player

scoreboard objectives remove survisland.pr_stoupy_duo
scoreboard objectives remove survisland.pr_stoupy_duo.group
scoreboard objectives remove survisland.pr_stoupy_duo.phase
scoreboard objectives remove survisland.pr_stoupy_duo.pose
scoreboard objectives remove survisland.pr_stoupy_duo.sprint
scoreboard objectives remove survisland.pr_stoupy_duo.moving
schedule clear survisland:modes/pr_stoupy/duo/tick

