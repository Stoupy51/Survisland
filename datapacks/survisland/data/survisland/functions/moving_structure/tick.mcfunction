
# Launch movement
execute store result score #state survisland.data run data get entity @s data.state
execute if score #state survisland.data matches 0 if score @s survisland.cooldown matches ..-50 if entity @a[distance=..1,tag=!survisland.moving_structure_immune,gamemode=!spectator] run function survisland:moving_structure/launch_timer
execute if score #state survisland.data matches 1 if score @s survisland.cooldown matches ..-50 run function survisland:moving_structure/check_destination with entity @s data

# Move players
execute if score @s survisland.cooldown matches 0.. run function survisland:moving_structure/action_movement

# Decrease cooldown
execute unless score @s survisland.cooldown matches ..-50 run scoreboard players remove @s survisland.cooldown 1

