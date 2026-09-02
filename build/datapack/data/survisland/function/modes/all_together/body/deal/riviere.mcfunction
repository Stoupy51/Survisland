
#> survisland:modes/all_together/body/deal/riviere
#
# @executed	as @a[tag=survisland.all_together]
#
# @within	survisland:modes/all_together/body/enter_phase/riviere [ as @a[tag=survisland.all_together] ]
#

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
execute if score @s survisland.all_together matches 2 run tag @s add survisland.all_together.forward
execute if score @s survisland.all_together matches 4 run tag @s add survisland.all_together.forward
execute if score @s survisland.all_together matches 3 run tag @s add survisland.all_together.backward
execute if score @s survisland.all_together matches 3 run tag @s add survisland.all_together.jump
execute if score @s survisland.all_together matches 1 run tag @s add survisland.all_together.look

# Only the click holders keep a usable interaction range
attribute @s minecraft:entity_interaction_range base set 0
attribute @s minecraft:block_interaction_range base set 0
execute if entity @s[tag=survisland.all_together.click] run attribute @s minecraft:entity_interaction_range base reset
execute if entity @s[tag=survisland.all_together.click] run attribute @s minecraft:block_interaction_range base reset

# Announce the new command set
title @s title {"text": "Partie 2 - Rivière", "color": "gold"}
title @s subtitle {"text": "Nouveau set de commandes", "color": "gray"}
tellraw @s [{"text": "\n"}, {"text": "Joueur 1 : ", "color": "yellow"}, {"text": "Tourner la tête\n", "color": "white"}, {"text": "Joueur 2 : ", "color": "yellow"}, {"text": "Avancer\n", "color": "white"}, {"text": "Joueur 3 : ", "color": "yellow"}, {"text": "Reculer / Sauter\n", "color": "white"}, {"text": "Joueur 4 : ", "color": "yellow"}, {"text": "Avancer\n", "color": "white"}]
playsound block.note_block.pling master @s

