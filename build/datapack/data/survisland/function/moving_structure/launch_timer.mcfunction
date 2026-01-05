
#> survisland:moving_structure/launch_timer
#
# @executed	at @s
#
# @within	survisland:moving_structure/check_destination
#			survisland:moving_structure/tick
#

# 1s cooldown before launch
scoreboard players remove @s survisland.cooldown 1
execute if score @s survisland.cooldown matches -70 run function survisland:moving_structure/action_launch

