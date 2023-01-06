
tag Stoupy51 add convention.debug

scoreboard objectives add survisland.data dummy
scoreboard objectives add survisland.right_click minecraft.used:minecraft.warped_fungus_on_a_stick

scoreboard players set survisland load.status 1010
forceload add 0 0

#define storage survisland:main
#define score_holder #success
#define score_holder #valid
#define score_holder #count
#define score_holder #temp
#define score_holder #pos

##Storage
#tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Souhaitez tous la bienvenue à "},{"selector":"@s","color":"aqua"},{"text":" !\nIl est le "},{"score":{"name":"#next_id","objective":"survisland.data"},"color":"aqua"},{"text":"ème joueur a rejoindre !"}]
data modify storage survisland:main SurvislandWarning set value '[{"text":"[SurvislandWarning]","color":"gold"}]'
data modify storage survisland:main SurvislandError set value '[{"text":"[SurvislandError]","color":"red"}]'
data modify storage survisland:main SurvislandHelp set value '[{"text":"[","color":"dark_aqua"},{"text":"SurvislandHelp","color":"aqua"},{"text":"]","color":"dark_aqua"}]'
data modify storage survisland:main Survisland set value '[{"text":"[","color":"dark_aqua"},{"text":"Survisland","color":"aqua"},{"text":"]","color":"dark_aqua"}]'

function survisland:set_constants

