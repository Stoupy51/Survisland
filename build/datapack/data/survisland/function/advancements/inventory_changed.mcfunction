
#> survisland:advancements/inventory_changed
#
# @executed	as the player & at current position
#
# @within	advancement survisland:inventory_changed
#

# Advancement revoke
advancement revoke @s only survisland:inventory_changed

# A pendent shows its carried form in the main hand and its worn form in the off hand
execute if data entity @s SelectedItem.components."minecraft:custom_data".survisland.pendent run item modify entity @s weapon.mainhand survisland:switch_pendent_state/mainhand
execute if data entity @s equipment.offhand.components."minecraft:custom_data".survisland.pendent run item modify entity @s weapon.offhand survisland:switch_pendent_state/offhand

# If has idol in inventory for first time, tell spectators
execute store success score #success survisland.data run function survisland:utils/has_item {"item":"pendent"}
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=aMJ] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=aStaff] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=zSpec] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=zOut] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 run tag @s add survisland.has_idol
execute if score #success survisland.data matches 0 run tag @s remove survisland.has_idol

