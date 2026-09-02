
#> survisland:modes/all_together/stop
#
# @within	???
#

# Stop every group still running
execute as @e[type=mannequin,tag=survisland.all_together.body] at @s run function survisland:modes/all_together/body/stop
kill @e[type=mannequin,tag=survisland.all_together.body]

# Catch anyone who ended up out of range of their body
execute as @a[tag=survisland.all_together] run function survisland:modes/all_together/body/release_player

scoreboard objectives remove survisland.all_together
scoreboard objectives remove survisland.all_together.group
scoreboard objectives remove survisland.all_together.phase
scoreboard objectives remove survisland.all_together.pose
scoreboard objectives remove survisland.all_together.sprint
schedule clear survisland:modes/all_together/tick

