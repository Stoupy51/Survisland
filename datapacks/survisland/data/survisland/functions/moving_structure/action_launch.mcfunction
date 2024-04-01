
# Set offset to every block_display with an interpolation time
data modify storage survisland:temp merge set value {interpolation_duration:100,start_interpolation:0,transformation:{translation:[0.0f,0.0f,0.0f]}}
data modify storage survisland:temp merge.interpolation_duration set from entity @s data.duration
execute if data entity @s data{state:0b} run data modify storage survisland:temp merge.transformation.translation set from entity @s data.offset
execute as @e[type=block_display,distance=..5] run data modify entity @s {} merge from storage survisland:temp merge

# Invert the state
execute store result score #state survisland.data run data get entity @s data.state
execute if score #state survisland.data matches 0 run data modify entity @s data.state set value 1b
execute if score #state survisland.data matches 1 run data modify entity @s data.state set value 0b

# Set cooldown
execute store result score @s survisland.cooldown run data get entity @s data.duration

