
#> survisland:modes/all_together/tick
#
# @within	survisland:modes/all_together/start 1t replace [ scheduled ]
#			survisland:modes/all_together/tick 1t replace [ scheduled ]
#

# The loop dies with the last group, and any start brings it back
execute unless entity @e[type=mannequin,tag=survisland.all_together.body,limit=1] run return 0
schedule function survisland:modes/all_together/tick 1t replace

# Every group is driven from the point of view of its own mannequin (position and rotation)
execute as @e[type=mannequin,tag=survisland.all_together.body] at @s run function survisland:modes/all_together/body/tick

