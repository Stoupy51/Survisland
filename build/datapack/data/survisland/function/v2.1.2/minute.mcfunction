
#> survisland:v2.1.2/minute
#
# @within	survisland:v2.1.2/tick
#

# Reset timer
scoreboard players set #minute survisland.data 1

# Timer
scoreboard players set #second survisland.data 0

# Check if their marker is still there
kill @e[type=marker,tag=survisland.keep_inventory]

