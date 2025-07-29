
#> survisland:advancements/inventory_changed
#
# @executed	as the player & at current position
#
# @within	advancement survisland:inventory_changed
#

# Advancement revoke
advancement revoke @s only survisland:inventory_changed

# If pendent in left or right hand, run switch function
scoreboard players set #success survisland.data 0
execute store success score #success survisland.data if data entity @s SelectedItem.components{"minecraft:item_model":"survisland:pendent_held"} run function survisland:utils/pendent_switch
execute if score #success survisland.data matches 0 if data entity @s equipment.offhand.components{"minecraft:item_model":"survisland:pendent"} run function survisland:utils/pendent_switch

# If has idol in inventory for first time, tell spectators
scoreboard players set #success survisland.data 0
execute if score #success survisland.data matches 0 if items entity @s container.* *[custom_data~{"survisland":{"pendent":true}}] run scoreboard players set #success survisland.data 1
execute if score #success survisland.data matches 0 if items entity @s container.* *[custom_data~{"survisland":{"pendent_held":true}}] run scoreboard players set #success survisland.data 1
execute if score #success survisland.data matches 0 if items entity @s player.cursor *[custom_data~{"survisland":{"pendent":true}}] run scoreboard players set #success survisland.data 1
execute if score #success survisland.data matches 0 if items entity @s player.cursor *[custom_data~{"survisland":{"pendent_held":true}}] run scoreboard players set #success survisland.data 1
execute if score #success survisland.data matches 0 if data entity @s Inventory[].components."minecraft:custom_data".survisland.pendent run scoreboard players set #success survisland.data 1
execute if score #success survisland.data matches 0 if data entity @s Inventory[].components."minecraft:custom_data".survisland.pendent_held run scoreboard players set #success survisland.data 1
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=aMJ] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=aStaff] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=zSpec] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=zOut] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 run tag @s add survisland.has_idol
execute if score #success survisland.data matches 0 run tag @s remove survisland.has_idol

