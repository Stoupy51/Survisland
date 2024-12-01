
# Imports
from python_datapack.constants import *
from python_datapack.utils.print import *
from python_datapack.utils.io import *

# Generates trivial things in the datapack
def main(config: dict) -> None:
	namespace: str = config["namespace"]
	version: str = config["version"]
	database: dict[str, dict] = config['database']
	functions: str = f"{config['build_datapack']}/data/{namespace}/function"
	advancements: str = f"{config['build_datapack']}/data/{namespace}/advancement"

	# Add additional objectives and gamerules to the load function
	write_to_file(f"{functions}/v{version}/load/confirm_load.mcfunction", f"""
scoreboard objectives add {namespace}.id dummy
scoreboard objectives add {namespace}.right_click minecraft.used:minecraft.warped_fungus_on_a_stick
scoreboard objectives add {namespace}.deathCount deathCount
scoreboard objectives add {namespace}.cooldown dummy

function {namespace}:set_constants
gamerule keepInventory true
scoreboard players set #keepInventory {namespace}.data 0
data modify storage {namespace}:main ScrollTexts set value []
forceload add 0 0

## Storage for easy tellraws
#tellraw @a ["\\n",{{"nbt":"Survisland","storage":"{namespace}:main","interpret":true}},{{"text":" Souhaitez tous la bienvenue à "}},{{"selector":"@s","color":"aqua"}},{{"text":" !\\nIl est le "}},{{"score":{{"name":"#next_id","objective":"{namespace}.data"}},"color":"aqua"}},{{"text":"ème joueur a rejoindre !"}}]
data modify storage {namespace}:main SurvislandSpec set value '[{{"text":"[SurvislandSpec]","color":"gray"}}]'
data modify storage {namespace}:main SurvislandWarning set value '[{{"text":"[SurvislandWarning]","color":"gold"}}]'
data modify storage {namespace}:main SurvislandRatio set value '[{{"text":"[SurvislandRatio]","color":"green"}}]'
data modify storage {namespace}:main SurvislandError set value '[{{"text":"[SurvislandError]","color":"red"}}]'
data modify storage {namespace}:main SurvislandHelp set value '[{{"text":"[","color":"dark_aqua"}},{{"text":"SurvislandHelp","color":"aqua"}},{{"text":"]","color":"dark_aqua"}}]'
data modify storage {namespace}:main Survisland set value '[{{"text":"[","color":"dark_aqua"}},{{"text":"Survisland","color":"aqua"}},{{"text":"]","color":"dark_aqua"}}]'
""")
	
	# Tick function
	write_to_file(f"{functions}/v{version}/tick.mcfunction", f"""
# Custom Keep Inventory System
execute as @a[scores={{{namespace}.deathCount=1..}}] at @s run function {namespace}:keep_inventory/player_died

# Moving Structure
execute as @e[type=marker,tag={namespace}.moving_structure] at @s run function {namespace}:moving_structure/tick

# Fart (BECAUSE FARTS ARE FUNNY XDDDDD LOL)
execute as @a[tag={namespace}.can_fart,tag=!{namespace}.farted,predicate={namespace}:is_sneaking] at @s run function {namespace}:utils/fart
tag @a[tag={namespace}.farted,predicate=!{namespace}:is_sneaking] remove {namespace}.farted
""")
	
	# Second function
	write_to_file(f"{functions}/v{version}/second.mcfunction", f"""
# Check if their marker is still there
execute as @a run function {namespace}:player/check_marker

# System pour les zones de gamemode adventure
function {namespace}:adventure_zone/second

# Disable smart ore generation from SimplEnergy
scoreboard players set _IS_ENABLED smart_ore_generation.data 0
""")
	
	# Minute function
	write_to_file(f"{functions}/v{version}/minute.mcfunction", f"""
# Timer
scoreboard players set #second {namespace}.data 0

# Check if their marker is still there
kill @e[type=marker,tag={namespace}.keep_inventory]
""")
	
	# Right click
	json_content: dict = {"criteria":{"requirement":{"trigger":"minecraft:tick","conditions":{"player":[{"condition":"minecraft:entity_scores","entity":"this","scores":{f"{namespace}.right_click":{"min":1}}}]}}},"rewards":{"function":f"{namespace}:utils/right_click"}}
	write_to_file(f"{advancements}/right_click.json", super_json_dump(json_content, max_level = -1))
	write_to_file(f"{functions}/utils/right_click.mcfunction", f"""
# Advancement revoke
advancement revoke @s only {namespace}:right_click

# Switch case
tag @s add {namespace}.temp
scoreboard players set #success {namespace}.data 0
execute if score #success {namespace}.data matches 0 store success score #success {namespace}.data if data entity @s SelectedItem.components{{"minecraft:item_model":"{database['parchemin']['item_model']}"}} run function {namespace}:parchemins/deploy_open
execute if score #success {namespace}.data matches 0 store success score #success {namespace}.data if data entity @s SelectedItem.components{{"minecraft:item_model":"{database['deployed_parchemin']['item_model']}"}} run function {namespace}:parchemins/deploy_close
execute if score #success {namespace}.data matches 0 store success score #success {namespace}.data if data entity @s SelectedItem.components."minecraft:custom_data".{namespace}.snuffer positioned ^ ^ ^2 as @p[gamemode=!spectator,tag=!{namespace}.temp,distance=..3] at @s run function {namespace}:utils/snuffer
execute if score #success {namespace}.data matches 0 store success score #success {namespace}.data if data entity @s Inventory[{{Slot:-106b}}].components."minecraft:custom_data".{namespace}.snuffer positioned ^ ^ ^2 as @p[gamemode=!spectator,distance=..3] at @s run function {namespace}:utils/snuffer

# Reset score and tag
scoreboard players reset @s {namespace}.right_click
tag @s remove {namespace}.temp
""")
	
	# parchemins/_convert_to_scroll
	parchemin: dict = database['parchemin']
	p_id: str = parchemin['id']
	p_model: str = parchemin['item_model']
	write_to_file(f"{functions}/parchemins/_convert_to_scroll.mcfunction", f"""
# Replace the book by a scroll
data modify storage {namespace}:main Item.id set value "{p_id}"
data modify storage {namespace}:main Item.components."minecraft:item_model" set value "{p_model}"
""")
	
	# advancements/inventory_changed
	pendent_model: str = database['pendent']['item_model']
	pendent_held_model: str = database['pendent_held']['item_model']
	write_to_file(f"{functions}/advancements/inventory_changed.mcfunction", f"""
# Advancement revoke
advancement revoke @s only survisland:inventory_changed

# If pendent in left or right hand, run switch function
scoreboard players set #success {namespace}.data 0
execute store success score #success {namespace}.data if data entity @s SelectedItem.components{{"minecraft:item_model":"{pendent_held_model}"}} run function {namespace}:utils/pendent_switch
execute if score #success {namespace}.data matches 0 if data entity @s Inventory[{{Slot:-106b}}].components{{"minecraft:item_model":"{pendent_model}"}} run function {namespace}:utils/pendent_switch
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

