
#> survisland:modes/all_together/body/deal/clairiere
#
# @executed	as @a[tag=survisland.all_together,distance=..50]
#
# @within	survisland:modes/all_together/body/set_phase/clairiere [ as @a[tag=survisland.all_together,distance=..50] ]
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
execute if score @s survisland.all_together matches 1 run tag @s add survisland.all_together.forward
execute if score @s survisland.all_together matches 1 run tag @s add survisland.all_together.backward
execute if score @s survisland.all_together matches 3 run tag @s add survisland.all_together.left
execute if score @s survisland.all_together matches 3 run tag @s add survisland.all_together.right
execute if score @s survisland.all_together matches 3 run tag @s add survisland.all_together.jump
execute if score @s survisland.all_together matches 4 run tag @s add survisland.all_together.look
execute if score @s survisland.all_together matches 2 run tag @s add survisland.all_together.click

# Only the click holders keep a usable interaction range
attribute @s minecraft:entity_interaction_range base set 0
attribute @s minecraft:block_interaction_range base set 0
execute if entity @s[tag=survisland.all_together.click] run attribute @s minecraft:entity_interaction_range base reset
execute if entity @s[tag=survisland.all_together.click] run attribute @s minecraft:block_interaction_range base reset

# Announce the new command set
title @s title {"text": "Partie 1 - Clairière", "color": "gold"}
title @s subtitle {"text": "Nouveau set de commandes", "color": "gray"}
tellraw @s [{"text": "\n"}, {"text": "Joueur 1 : ", "color": "yellow"}, {"text": "Avancer / Reculer\n", "color": "white"}, {"text": "Joueur 2 : ", "color": "yellow"}, {"text": "Clic gauche / Clic droit\n", "color": "white"}, {"text": "Joueur 3 : ", "color": "yellow"}, {"text": "Marcher à gauche / Marcher à droite / Sauter\n", "color": "white"}, {"text": "Joueur 4 : ", "color": "yellow"}, {"text": "Tourner la tête\n", "color": "white"}]
playsound block.note_block.pling master @s

