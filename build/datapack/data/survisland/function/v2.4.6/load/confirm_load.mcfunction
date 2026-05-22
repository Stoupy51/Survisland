
#> survisland:v2.4.6/load/confirm_load
#
# @within	survisland:v2.4.6/load/valid_dependencies
#

# Confirm load
tellraw @a[tag=convention.debug] {"text":"[Loaded Survisland v2.4.6]","color":"green"}
scoreboard players set #survisland.loaded load.status 1
function survisland:v2.4.6/load/set_items_storage

# Add objectives
scoreboard objectives add survisland.id dummy
scoreboard objectives add survisland.right_click minecraft.used:minecraft.warped_fungus_on_a_stick
scoreboard objectives add survisland.deathCount deathCount
scoreboard objectives add survisland.cooldown dummy
scoreboard objectives add survisland.relative.x dummy
scoreboard objectives add survisland.relative.y dummy
scoreboard objectives add survisland.relative.z dummy

# Add common teams
team add survisland.no_collision
team modify survisland.no_collision collisionRule never

# Set constants
function survisland:set_constants

# Set gamerules
gamerule keep_inventory true
scoreboard players set #keepInventory survisland.data 0

# Set some storage and forceload
data modify storage survisland:main ScrollTexts set value []
forceload add 0 0

## Storage for easy tellraws
#tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Souhaitez tous la bienvenue à "},{"selector":"@s","color":"aqua"},{"text":" !\nIl est le "},{"score":{"name":"#next_id","objective":"survisland.data"},"color":"aqua"},{"text":"ème joueur a rejoindre !"}]
data modify storage survisland:main SurvislandSpec set value [{"text":"[SurvislandSpec]","color":"gray"}]
data modify storage survisland:main SurvislandWarning set value [{"text":"[Survisland]","color":"gold"}]
data modify storage survisland:main SurvislandRatio set value [{"text":"[SurvislandRatio]","color":"green"}]
data modify storage survisland:main SurvislandError set value [{"text":"[SurvislandError]","color":"red"}]
data modify storage survisland:main SurvislandHelp set value [{"text":"[","color":"dark_aqua"},{"text":"SurvislandHelp","color":"aqua"},{"text":"]","color":"dark_aqua"}]
data modify storage survisland:main Survisland set value [{"text":"[","color":"dark_aqua"},{"text":"Survisland","color":"aqua"},{"text":"]","color":"dark_aqua"}]

