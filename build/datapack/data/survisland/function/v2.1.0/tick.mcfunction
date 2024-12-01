
#> survisland:v2.1.0/tick
#
# @within	survisland:v2.1.0/load/tick_verification
#

# Timers
scoreboard players add #second survisland.data 1
scoreboard players add #minute survisland.data 1
execute if score #second survisland.data matches 20.. run function survisland:v2.1.0/second
execute if score #minute survisland.data matches 1200.. run function survisland:v2.1.0/minute

# Custom Keep Inventory System
execute as @e[type=marker,tag=survisland.keep_inventory] at @s run function survisland:keep_inventory/tick
scoreboard players reset @a[scores={survisland.deathCount=1..}] survisland.deathCount

# Moving Structure
execute as @e[type=marker,tag=survisland.moving_structure] at @s run function survisland:moving_structure/tick

# Fart (BECAUSE FARTS ARE FUNNY XDDDDD LOL)
execute as @a[tag=survisland.can_fart,tag=!survisland.farted,predicate=survisland:is_sneaking] at @s run function survisland:utils/fart
tag @a[tag=survisland.farted,predicate=!survisland:is_sneaking] remove survisland.farted

