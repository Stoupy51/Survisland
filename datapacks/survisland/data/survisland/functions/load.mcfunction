
tag Stoupy51 add convention.debug

scoreboard objectives add survisland.id dummy
scoreboard objectives add survisland.data dummy
scoreboard objectives add survisland.right_click minecraft.used:minecraft.warped_fungus_on_a_stick
scoreboard objectives add survisland.deathCount deathCount

scoreboard players set survisland load.status 1020
scoreboard players add #keepInventory survisland.data 0
data modify storage survisland:main ScrollTexts set value []
forceload add 0 0

gamerule keepInventory true

#define storage survisland:items
#define storage survisland:main
#define score_holder #success
#define score_holder #valid
#define score_holder #count
#define score_holder #temp
#define score_holder #pos

## Storage
#tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Souhaitez tous la bienvenue à "},{"selector":"@s","color":"aqua"},{"text":" !\nIl est le "},{"score":{"name":"#next_id","objective":"survisland.data"},"color":"aqua"},{"text":"ème joueur a rejoindre !"}]
data modify storage survisland:main SurvislandWarning set value '[{"text":"[SurvislandWarning]","color":"gold"}]'
data modify storage survisland:main SurvislandError set value '[{"text":"[SurvislandError]","color":"red"}]'
data modify storage survisland:main SurvislandHelp set value '[{"text":"[","color":"dark_aqua"},{"text":"SurvislandHelp","color":"aqua"},{"text":"]","color":"dark_aqua"}]'
data modify storage survisland:main Survisland set value '[{"text":"[","color":"dark_aqua"},{"text":"Survisland","color":"aqua"},{"text":"]","color":"dark_aqua"}]'

## Scoreboard constants
function survisland:set_constants

## Items
# Parchemin
data modify storage survisland:items all.parchemin set value {Slot:16b		,id:"minecraft:warped_fungus_on_a_stick"	,Count:1b,tag:{ctc:{id:"parchemin",from:"stoupy:survisland",traits:{}}			,CustomModelData:2010001,survisland:{parchemin:1b}			,display:{Lore:['{"italic":false,"color":"gold","extra":[{"color":"yellow","text":"Stoupy51"}],"text":"Auteur : "}'],Name:'{"italic":false,"color":"red","text":"Default vote"}'}}}
# Snuffer
data modify storage survisland:items all.snuffer set value {Slot:16b		,id:"minecraft:warped_fungus_on_a_stick"	,Count:1b,tag:{ctc:{id:"snuffer",from:"stoupy:survisland",traits:{}}			,CustomModelData:2010004,survisland:{snuffer:1b}			,display:{Lore:['[{"text":"Clic-droit pour éteindre la torche","italic":false,"color":"gray"}]','[{"text":"du joueur le plus proche","italic":false,"color":"gray"}]','{"translate":"Survisland","color":"blue","italic":true}'],Name:'[{"text":"Snuffer","italic":false,"color":"white"}]'}}}
# Flambeau (Torche)
data modify storage survisland:items all.flambeau set value {Slot:16b		,id:"minecraft:warped_fungus_on_a_stick"	,Count:1b,tag:{ctc:{id:"flambeau",from:"stoupy:survisland",traits:{}}			,CustomModelData:2010005,survisland:{flambeau:1b}			,display:{Lore:['[{"text":"Gardez cette torche précieusement","italic":false,"color":"gray"}]','{"translate":"Survisland","color":"blue","italic":true}'],Name:'[{"text":"Le Flambeau","italic":false,"color":"white"}]'}}}

