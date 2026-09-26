
#> survisland:modes/pr_stoupy/duo/body/deal/laboratoire
#
# @executed	as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50]
#
# @within	survisland:modes/pr_stoupy/duo/body/enter_phase/laboratoire [ as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] ]
#

# The click holder rides its own seat, so a new command set can mean a new vehicle
execute if predicate survisland:riding run ride @s dismount

# Clear the previous command set
tag @s remove survisland.pr_stoupy_duo.forward
tag @s remove survisland.pr_stoupy_duo.backward
tag @s remove survisland.pr_stoupy_duo.left
tag @s remove survisland.pr_stoupy_duo.right
tag @s remove survisland.pr_stoupy_duo.jump
tag @s remove survisland.pr_stoupy_duo.sneak
tag @s remove survisland.pr_stoupy_duo.sprint
tag @s remove survisland.pr_stoupy_duo.crawl
tag @s remove survisland.pr_stoupy_duo.look
tag @s remove survisland.pr_stoupy_duo.click

# Give the command set of this part
execute if score @s survisland.pr_stoupy_duo matches 1 run tag @s add survisland.pr_stoupy_duo.forward
execute if score @s survisland.pr_stoupy_duo matches 1 run tag @s add survisland.pr_stoupy_duo.backward
execute if score @s survisland.pr_stoupy_duo matches 2 run tag @s add survisland.pr_stoupy_duo.left
execute if score @s survisland.pr_stoupy_duo matches 2 run tag @s add survisland.pr_stoupy_duo.right
execute if score @s survisland.pr_stoupy_duo matches 2 run tag @s add survisland.pr_stoupy_duo.jump
execute if score @s survisland.pr_stoupy_duo matches 2 run tag @s add survisland.pr_stoupy_duo.sneak
execute if score @s survisland.pr_stoupy_duo matches 1 run tag @s add survisland.pr_stoupy_duo.sprint
execute if score @s survisland.pr_stoupy_duo matches 2 run tag @s add survisland.pr_stoupy_duo.crawl
execute if score @s survisland.pr_stoupy_duo matches 1 run tag @s add survisland.pr_stoupy_duo.look
execute if score @s survisland.pr_stoupy_duo matches 2 run tag @s add survisland.pr_stoupy_duo.click

# Only the click holder keeps a body able to touch the world
attribute @s minecraft:block_break_speed base reset
attribute @s minecraft:entity_interaction_range base set 0
attribute @s minecraft:block_interaction_range base set 0
execute if entity @s[tag=survisland.pr_stoupy_duo.click] run function survisland:modes/pr_stoupy/duo/body/deal_click

# Announce the new command set
title @s title {"text": "Laboratoire - Duo", "color": "gold"}
title @s subtitle {"text": "Nouveau set de commandes", "color": "gray"}
playsound block.note_block.pling master @s

