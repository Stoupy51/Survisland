
# Launch movement
execute if score @s survisland.cooldown matches -50 if entity @a[distance=..1,tag=!survisland.moving_structure_immune] run function survisland:moving_structure/action_launch

# Move players (#TODO)
#execute if score @s survisland.cooldown matches 1.. run particle glow ~ ~4 ~ 0.5 0.5 0.5 0 5

# TODO: ID system to prevent moving structures collisions

# Decrease cooldown
execute unless score @s survisland.cooldown matches ..-50 run scoreboard players remove @s survisland.cooldown 1

