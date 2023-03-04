
# ID System
scoreboard players add #next_id survisland.id 1
scoreboard players operation @s survisland.id = #next_id survisland.id

# Summon Keep Inventory Marker
summon marker 0 0 0 {Tags:["survisland.new","survisland.keep_inventory","global.ignore","global.ignore.kill","smithed.strict","smithed.entity"]}
execute as @e[type=marker,tag=survisland.new] run function survisland:player/keep_inventory_marker

