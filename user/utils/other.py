
# Imports
from python_datapack.constants import *
from python_datapack.utils.print import *
from python_datapack.utils.io import *

# Generates trivial things in the datapack
def main(config: dict) -> None:
	ns: str = config["namespace"]
	version: str = config["version"]
	database: dict[str, dict] = config['database']
	functions: str = f"{config['build_datapack']}/data/{ns}/function"
	advancements: str = f"{config['build_datapack']}/data/{ns}/advancement"

	# Add additional objectives and gamerules to the load function
	write_to_load_file(config, f"""
# Add objectives
scoreboard objectives add {ns}.id dummy
scoreboard objectives add {ns}.right_click minecraft.used:minecraft.warped_fungus_on_a_stick
scoreboard objectives add {ns}.deathCount deathCount
scoreboard objectives add {ns}.cooldown dummy

# Add common teams
team add {ns}.no_collision
team modify {ns}.no_collision collisionRule never

# Set constants
function {ns}:set_constants

# Set gamerules
gamerule keepInventory true
scoreboard players set #keepInventory {ns}.data 0

# Set some storage and forceload
data modify storage {ns}:main ScrollTexts set value []
forceload add 0 0

## Storage for easy tellraws
#tellraw @a ["\\n",{{"nbt":"Survisland","storage":"{ns}:main","interpret":true}},{{"text":" Souhaitez tous la bienvenue à "}},{{"selector":"@s","color":"aqua"}},{{"text":" !\\nIl est le "}},{{"score":{{"name":"#next_id","objective":"{ns}.data"}},"color":"aqua"}},{{"text":"ème joueur a rejoindre !"}}]
data modify storage {ns}:main SurvislandSpec set value '[{{"text":"[SurvislandSpec]","color":"gray"}}]'
data modify storage {ns}:main SurvislandWarning set value '[{{"text":"[Survisland]","color":"gold"}}]'
data modify storage {ns}:main SurvislandRatio set value '[{{"text":"[SurvislandRatio]","color":"green"}}]'
data modify storage {ns}:main SurvislandError set value '[{{"text":"[SurvislandError]","color":"red"}}]'
data modify storage {ns}:main SurvislandHelp set value '[{{"text":"[","color":"dark_aqua"}},{{"text":"SurvislandHelp","color":"aqua"}},{{"text":"]","color":"dark_aqua"}}]'
data modify storage {ns}:main Survisland set value '[{{"text":"[","color":"dark_aqua"}},{{"text":"Survisland","color":"aqua"}},{{"text":"]","color":"dark_aqua"}}]'
""")
	
	# Tick function
	write_to_file(f"{functions}/v{version}/tick.mcfunction", f"""
# Custom Keep Inventory System
execute as @a[scores={{{ns}.deathCount=1..}}] at @s run function {ns}:keep_inventory/player_died

# Moving Structure
execute as @e[type=marker,tag={ns}.moving_structure] at @s run function {ns}:moving_structure/tick

# Fart (BECAUSE FARTS ARE FUNNY XDDDDD LOL)
execute as @a[tag={ns}.can_fart,tag=!{ns}.farted,predicate={ns}:is_sneaking] at @s run function {ns}:utils/fart
tag @a[tag={ns}.farted,predicate=!{ns}:is_sneaking] remove {ns}.farted
""")
	
	# Second function
	write_to_file(f"{functions}/v{version}/second.mcfunction", f"""
# Check if their marker is still there
execute as @a run function {ns}:player/check_marker

# System pour les zones de gamemode adventure
function {ns}:adventure_zone/second

# Disable smart ore generation from SimplEnergy
scoreboard players set _IS_ENABLED smart_ore_generation.data 0
""")
	
	# Minute function
	write_to_file(f"{functions}/v{version}/minute.mcfunction", f"""
# Timer
scoreboard players set #second {ns}.data 0

# Check if their marker is still there
kill @e[type=marker,tag={ns}.keep_inventory]
""")
	
	# Right click
	json_content: dict = {"criteria":{"requirement":{"trigger":"minecraft:tick","conditions":{"player":[{"condition":"minecraft:entity_scores","entity":"this","scores":{f"{ns}.right_click":{"min":1}}}]}}},"rewards":{"function":f"{ns}:utils/right_click"}}
	write_to_file(f"{advancements}/right_click.json", super_json_dump(json_content, max_level = -1))
	write_to_file(f"{functions}/utils/right_click.mcfunction", f"""
# Advancement revoke
advancement revoke @s only {ns}:right_click

# Switch case
tag @s add {ns}.temp
scoreboard players set #success {ns}.data 0
execute if score #success {ns}.data matches 0 store success score #success {ns}.data if data entity @s SelectedItem.components{{"minecraft:item_model":"{database['parchemin']['item_model']}"}} run function {ns}:parchemins/deploy_open
execute if score #success {ns}.data matches 0 store success score #success {ns}.data if data entity @s SelectedItem.components{{"minecraft:item_model":"{database['deployed_parchemin']['item_model']}"}} run function {ns}:parchemins/deploy_close
execute if score #success {ns}.data matches 0 store success score #success {ns}.data if data entity @s SelectedItem.components."minecraft:custom_data".{ns}.snuffer positioned ^ ^ ^2 as @p[gamemode=!spectator,tag=!{ns}.temp,distance=..3] at @s run function {ns}:utils/snuffer
execute if score #success {ns}.data matches 0 store success score #success {ns}.data if data entity @s Inventory[{{Slot:-106b}}].components."minecraft:custom_data".{ns}.snuffer positioned ^ ^ ^2 as @p[gamemode=!spectator,distance=..3] at @s run function {ns}:utils/snuffer

# Reset score and tag
scoreboard players reset @s {ns}.right_click
tag @s remove {ns}.temp
""")
	
	# parchemins/_convert_to_scroll
	parchemin: dict = database['parchemin']
	p_id: str = parchemin['id']
	p_model: str = parchemin['item_model']
	write_to_file(f"{functions}/parchemins/_convert_to_scroll.mcfunction", f"""
# Replace the book by a scroll
data modify storage {ns}:main Item.id set value "{p_id}"
data modify storage {ns}:main Item.components."minecraft:item_model" set value "{p_model}"
""")
	
	# advancements/inventory_changed
	pendent_model: str = database['pendent']['item_model']
	pendent_held_model: str = database['pendent_held']['item_model']
	write_to_file(f"{functions}/advancements/inventory_changed.mcfunction", f"""
# Advancement revoke
advancement revoke @s only survisland:inventory_changed

# If pendent in left or right hand, run switch function
scoreboard players set #success {ns}.data 0
execute store success score #success {ns}.data if data entity @s SelectedItem.components{{"minecraft:item_model":"{pendent_held_model}"}} run function {ns}:utils/pendent_switch
execute if score #success {ns}.data matches 0 if data entity @s Inventory[{{Slot:-106b}}].components{{"minecraft:item_model":"{pendent_model}"}} run function {ns}:utils/pendent_switch

# If has idol in inventory for first time, tell spectators
scoreboard players set #success {ns}.data 0
execute if score #success {ns}.data matches 0 if items entity @s container.* *[custom_data~{{"survisland":{{"pendent":true}}}}] run scoreboard players set #success {ns}.data 1
execute if score #success {ns}.data matches 0 if items entity @s container.* *[custom_data~{{"survisland":{{"pendent_held":true}}}}] run scoreboard players set #success {ns}.data 1
execute if score #success {ns}.data matches 1 unless entity @s[tag={ns}.has_idol] run tellraw @a[gamemode=!adventure,gamemode=!survival] ["\\n",{{"nbt":"SurvislandSpec","storage":"{ns}:main","interpret":true}},{{"text":" Le joueur "}},{{"selector":"@s","color":"aqua"}},{{"text":" vient de récupérer un idol dans son inventaire !"}}]
execute if score #success {ns}.data matches 1 run tag @s add {ns}.has_idol
execute if score #success {ns}.data matches 0 run tag @s remove {ns}.has_idol
""")
	
	# utils/pendent_switch
	write_to_file(f"{functions}/utils/pendent_switch.mcfunction", f"""
# Copy du pendent dans un slot temporaire
setblock 0 5 0 air
setblock 0 5 0 barrel
execute if data entity @s SelectedItem.components{{"minecraft:item_model":"{pendent_held_model}"}} run item replace block 0 5 0 container.0 from entity @s weapon.mainhand
execute if data entity @s Inventory[{{Slot:-106b}}].components{{"minecraft:item_model":"{pendent_model}"}} run item replace block 0 5 0 container.0 from entity @s weapon.offhand

# Inversion du model data du pendent
execute if data entity @s SelectedItem.components{{"minecraft:item_model":"{pendent_held_model}"}} run data modify block 0 5 0 Items[0].components."minecraft:item_model" set value "{pendent_model}"
execute if data entity @s Inventory[{{Slot:-106b}}].components{{"minecraft:item_model":"{pendent_model}"}} run data modify block 0 5 0 Items[0].components."minecraft:item_model" set value "{pendent_held_model}"

# Recopie du pendent dans la main gauche
execute if data entity @s SelectedItem.components{{"minecraft:item_model":"{pendent_held_model}"}} run item replace entity @s weapon.mainhand from block 0 5 0 container.0
execute if data entity @s Inventory[{{Slot:-106b}}].components{{"minecraft:item_model":"{pendent_model}"}} run item replace entity @s weapon.offhand from block 0 5 0 container.0

# Suppression du slot temporaire
setblock 0 5 0 air
""")

