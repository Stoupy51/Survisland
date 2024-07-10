
# 1s cooldown before launch
scoreboard players remove @s survisland.cooldown 1
execute if score @s survisland.cooldown matches -70 run function survisland:moving_structure/action_launch

