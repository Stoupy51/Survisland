
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
execute if score #success survisland.data matches 0 store success score #success survisland.data run function survisland:utils/has_item {"item":"pendent"}
execute if score #success survisland.data matches 0 store success score #success survisland.data run function survisland:utils/has_item {"item":"pendent_held"}
execute if score #success survisland.data matches 0 store success score #success survisland.data run function survisland:utils/has_item {"item":"dragon_necklace"}
execute if score #success survisland.data matches 0 store success score #success survisland.data run function survisland:utils/has_item {"item":"dragon_flower_necklace"}
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=aMJ] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=aStaff] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=zSpec] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 unless entity @s[tag=survisland.has_idol] run tellraw @a[team=zOut] ["\n",{"nbt":"SurvislandSpec","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s","color":"aqua"},{"text":" vient de récupérer un idol dans son inventaire !"}]
execute if score #success survisland.data matches 1 run tag @s add survisland.has_idol
execute if score #success survisland.data matches 0 run tag @s remove survisland.has_idol

