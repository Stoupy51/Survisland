
#> survisland:v2.4.3/tick
#
# @within	survisland:v2.4.3/load/tick_verification
#

# Timers
scoreboard players add #second survisland.data 1
scoreboard players add #minute survisland.data 1
execute if score #second survisland.data matches 20.. run function survisland:v2.4.3/second
execute if score #minute survisland.data matches 1200.. run function survisland:v2.4.3/minute

# Custom Keep Inventory System
execute as @a[scores={survisland.deathCount=1..}] at @s run function survisland:keep_inventory/player_died

# Moving Structure
execute as @e[type=marker,tag=survisland.moving_structure] at @s run function survisland:moving_structure/tick

# Cinematic
execute if score #cinematic_entities survisland.data matches 1.. as @e[type=item_display,tag=survisland.cinematic] run function survisland:cinematic/entity_tick

# Fart (BECAUSE FARTS ARE FUNNY XDDDDD LOL)
execute as @a[tag=survisland.can_fart,tag=!survisland.farted,predicate=survisland:is_sneaking] at @s run function survisland:utils/fart
tag @a[tag=survisland.farted,predicate=!survisland:is_sneaking] remove survisland.farted

