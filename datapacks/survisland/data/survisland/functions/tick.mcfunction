
# Custom Keep Inventory System
execute as @e[type=marker,tag=survisland.keep_inventory] at @s run function survisland:keep_inventory/tick
scoreboard players reset @a[scores={survisland.deathCount=1..}] survisland.deathCount

# Timer
scoreboard players add #tick survisland.data 1
execute if score #tick survisland.data matches 20.. run function survisland:second


