
#> survisland:modes/shiren_trials/tick
#
# @within	survisland:modes/shiren_trials/start 1t replace [ scheduled ]
#			survisland:modes/shiren_trials/tick 1t replace [ scheduled ]
#

# Loop again
schedule function survisland:modes/shiren_trials/tick 1t replace

# Increment race time
scoreboard players add @a survisland.temp.race_start 1

# Glowing for blue stars
execute as @e[type=item,nbt={Item:{components:{"minecraft:custom_data":{"survisland":{"blue_star":true}}}}}] run data modify entity @s Glowing set value true

