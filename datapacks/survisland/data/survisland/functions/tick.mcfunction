
#> survisland:tick
#
# @within			minecraft function tag tick.json
# @executed			default context
#
# @description		Function executed every tick
#

# Custom Keep Inventory System
execute as @e[type=marker,tag=survisland.keep_inventory] at @s run function survisland:keep_inventory/tick
scoreboard players reset @a[scores={survisland.deathCount=1..}] survisland.deathCount

# Timer
scoreboard players add #tick survisland.data 1
execute if score #tick survisland.data matches 20.. run function survisland:second

# Moving Structure
execute as @e[type=marker,tag=survisland.moving_structure] at @s run function survisland:moving_structure/tick

# Fart (BECAUSE FARTS ARE FUNNY XDDDDD LOL)
execute as @a[tag=survisland.can_fart,tag=!survisland.farted,predicate=survisland:is_sneaking] at @s run function survisland:utils/fart
tag @a[tag=survisland.farted,predicate=!survisland:is_sneaking] remove survisland.farted

