
#> survisland:modes/all_together/body/deal/fort
#
# @executed	as @a[tag=survisland.all_together,distance=..50]
#
# @within	survisland:modes/all_together/body/enter_phase/fort [ as @a[tag=survisland.all_together,distance=..50] ]
#

# The click holder rides its own seat, so a new command set can mean a new vehicle
execute if predicate survisland:riding run ride @s dismount

# Clear the previous command set
tag @s remove survisland.all_together.forward
tag @s remove survisland.all_together.backward
tag @s remove survisland.all_together.left
tag @s remove survisland.all_together.right
tag @s remove survisland.all_together.jump
tag @s remove survisland.all_together.sneak
tag @s remove survisland.all_together.sprint
tag @s remove survisland.all_together.crawl
tag @s remove survisland.all_together.look
tag @s remove survisland.all_together.click

# Give the command set of this part
execute if score @s survisland.all_together matches 4 run tag @s add survisland.all_together.forward
execute if score @s survisland.all_together matches 2 run tag @s add survisland.all_together.backward
execute if score @s survisland.all_together matches 3 run tag @s add survisland.all_together.left
execute if score @s survisland.all_together matches 3 run tag @s add survisland.all_together.right
execute if score @s survisland.all_together matches 3 run tag @s add survisland.all_together.jump
execute if score @s survisland.all_together matches 4 run tag @s add survisland.all_together.sneak
execute if score @s survisland.all_together matches 3 run tag @s add survisland.all_together.sprint
execute if score @s survisland.all_together matches 4 run tag @s add survisland.all_together.crawl
execute if score @s survisland.all_together matches 2 run tag @s add survisland.all_together.look
execute if score @s survisland.all_together matches 1 run tag @s add survisland.all_together.click

# Only the click holder keeps a body able to touch the world
attribute @s minecraft:block_break_speed base reset
attribute @s minecraft:entity_interaction_range base set 0
attribute @s minecraft:block_interaction_range base set 0
execute if entity @s[tag=survisland.all_together.click] run function survisland:modes/all_together/body/deal_click

# Announce the new command set
title @s title {"text": "Partie 3 - Fort", "color": "gold"}
title @s subtitle {"text": "Nouveau set de commandes", "color": "gray"}
playsound block.note_block.pling master @s

