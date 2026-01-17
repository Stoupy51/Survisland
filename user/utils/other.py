
# ruff: noqa: E501
# Imports
import stouputils as stp
from beet import ItemTag
from stewbeet import Advancement, Item, ItemModel, JsonDict, Mem, set_json_encoder, write_function, write_load_file, write_tick_file, write_versioned_function


# Generates trivial things in the datapack
def main() -> None:
	ns: str = Mem.ctx.project_id

	# Add additional objectives and gamerules to the load function
	write_load_file(f"""
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
gamerule keep_inventory true
scoreboard players set #keepInventory {ns}.data 0

# Set some storage and forceload
data modify storage {ns}:main ScrollTexts set value []
forceload add 0 0

## Storage for easy tellraws
#tellraw @a ["\\n",{{"nbt":"Survisland","storage":"{ns}:main","interpret":true}},{{"text":" Souhaitez tous la bienvenue à "}},{{"selector":"@s","color":"aqua"}},{{"text":" !\\nIl est le "}},{{"score":{{"name":"#next_id","objective":"{ns}.data"}},"color":"aqua"}},{{"text":"ème joueur a rejoindre !"}}]
data modify storage {ns}:main SurvislandSpec set value [{{"text":"[SurvislandSpec]","color":"gray"}}]
data modify storage {ns}:main SurvislandWarning set value [{{"text":"[Survisland]","color":"gold"}}]
data modify storage {ns}:main SurvislandRatio set value [{{"text":"[SurvislandRatio]","color":"green"}}]
data modify storage {ns}:main SurvislandError set value [{{"text":"[SurvislandError]","color":"red"}}]
data modify storage {ns}:main SurvislandHelp set value [{{"text":"[","color":"dark_aqua"}},{{"text":"SurvislandHelp","color":"aqua"}},{{"text":"]","color":"dark_aqua"}}]
data modify storage {ns}:main Survisland set value [{{"text":"[","color":"dark_aqua"}},{{"text":"Survisland","color":"aqua"}},{{"text":"]","color":"dark_aqua"}}]
""")

	# Tick function
	write_tick_file(f"""
# Custom Keep Inventory System
execute as @a[scores={{{ns}.deathCount=1..}}] at @s run function {ns}:keep_inventory/player_died

# Moving Structure
execute as @e[type=marker,tag={ns}.moving_structure] at @s run function {ns}:moving_structure/tick

# Cinematic
execute if score #cinematic_entities survisland.data matches 1.. as @e[type=item_display,tag=survisland.cinematic] run function survisland:cinematic/entity_tick

# Fart (BECAUSE FARTS ARE FUNNY XDDDDD LOL)
execute as @a[tag={ns}.can_fart,tag=!{ns}.farted,predicate={ns}:is_sneaking] at @s run function {ns}:utils/fart
tag @a[tag={ns}.farted,predicate=!{ns}:is_sneaking] remove {ns}.farted
""")

	# Second function
	write_versioned_function("second", f"""
# Given an ID to every player who hasn't one
execute as @a run function {ns}:player/check_id

# System pour les zones de gamemode adventure
function {ns}:adventure_zone/second

# Disable smart ore generation from SimplEnergy
scoreboard players set _IS_ENABLED smart_ore_generation.data 0
""")

	# Minute function
	write_versioned_function("minute", f"""
# Timer
scoreboard players set #second {ns}.data 0

# Check if their marker is still there
kill @e[type=marker,tag={ns}.keep_inventory]
""")

	# Right click
	json_content: JsonDict = {"criteria":{"requirement":{"trigger":"minecraft:tick","conditions":{"player":[{"condition":"minecraft:entity_scores","entity":"this","scores":{f"{ns}.right_click":{"min":1}}}]}}},"rewards":{"function":f"{ns}:utils/right_click"}}
	Mem.ctx.data[ns].advancements["right_click"] = set_json_encoder(Advancement(json_content), max_level=-1)
	parchemin = Item.from_id("parchemin")
	deployed_parchemin = Item.from_id("deployed_parchemin")
	parchemin_item_model: str = parchemin.components["item_model"]
	deployed_item_model: str = deployed_parchemin.components["item_model"]
	write_function(f"{ns}:utils/right_click", f"""
# Advancement revoke
advancement revoke @s only {ns}:right_click

# Switch case
tag @s add {ns}.temp
scoreboard players set #success {ns}.data 0
execute if score #success {ns}.data matches 0 store success score #success {ns}.data if data entity @s SelectedItem.components{{"minecraft:item_model":"{parchemin_item_model}"}} run function {ns}:parchemins/deploy_open
execute if score #success {ns}.data matches 0 store success score #success {ns}.data if data entity @s SelectedItem.components{{"minecraft:item_model":"{deployed_item_model}"}} run function {ns}:parchemins/deploy_close
execute if score #success {ns}.data matches 0 store success score #success {ns}.data if data entity @s SelectedItem.components."minecraft:custom_data".{ns}.snuffer positioned ^ ^ ^2 as @p[gamemode=!spectator,tag=!{ns}.temp,distance=..3] at @s run function {ns}:utils/snuffer
execute if score #success {ns}.data matches 0 store success score #success {ns}.data if data entity @s equipment.offhand.components."minecraft:custom_data".{ns}.snuffer positioned ^ ^ ^2 as @p[gamemode=!spectator,distance=..3] at @s run function {ns}:utils/snuffer

# Reset score and tag
scoreboard players reset @s {ns}.right_click
tag @s remove {ns}.temp
""")

	# Make parchemins, and dragon_necklace tintables
	dragon_necklace = Item.from_id("dragon_necklace")
	Mem.ctx.data["minecraft"].item_tags["dyeable"] = set_json_encoder(ItemTag({"values":stp.unique_list([parchemin.base_item, dragon_necklace.base_item])}))
	Mem.ctx.assets[ns].item_models["parchemin"] = set_json_encoder(ItemModel({"model":{"type":"minecraft:model","model":f"{ns}:item/parchemin","tints":[{"type":"minecraft:dye","default":[0.780,0.737,0.647]}]}}), max_level=3)
	Mem.ctx.assets[ns].item_models["deployed_parchemin"] = set_json_encoder(ItemModel({"model":{"type":"minecraft:model","model":f"{ns}:item/deployed_parchemin","tints":[{"type":"minecraft:dye","default":[0.780,0.737,0.647]}]}}), max_level=3)
	Mem.ctx.assets[ns].item_models["dragon_necklace"] = set_json_encoder(ItemModel({"model":{"type":"minecraft:model","model":f"{ns}:item/dragon_necklace","tints":[{"type":"minecraft:dye","default":[1.0,1.0,1.0]}]}}), max_level=3)
	Mem.ctx.assets[ns].item_models["dragon_flower_necklace"] = set_json_encoder(ItemModel({"model":{"type":"minecraft:model","model":f"{ns}:item/dragon_flower_necklace","tints":[{"type":"minecraft:dye","default":[1.0,1.0,1.0]}]}}), max_level=3)

	# parchemins/_convert_to_scroll
	p_id: str = parchemin.base_item
	p_model: str = parchemin.components["item_model"]
	write_function(f"{ns}:parchemins/_convert_to_scroll", f"""
# Replace the book by a scroll
data modify storage {ns}:main Item.id set value "{p_id}"
data modify storage {ns}:main Item.components."minecraft:item_model" set value "{p_model}"
""")

	# advancements/inventory_changed
	pendent = Item.from_id("pendent")
	pendent_held = Item.from_id("pendent_held")
	pendent_model: str = pendent.components["item_model"]
	pendent_held_model: str = pendent_held.components["item_model"]
	write_function(f"{ns}:advancements/inventory_changed", f"""
# Advancement revoke
advancement revoke @s only survisland:inventory_changed

# If pendent in left or right hand, run switch function
scoreboard players set #success {ns}.data 0
execute store success score #success {ns}.data if data entity @s SelectedItem.components{{"minecraft:item_model":"{pendent_held_model}"}} run function {ns}:utils/pendent_switch
execute if score #success {ns}.data matches 0 if data entity @s equipment.offhand.components{{"minecraft:item_model":"{pendent_model}"}} run function {ns}:utils/pendent_switch

# If has idol in inventory for first time, tell spectators
scoreboard players set #success {ns}.data 0
execute if score #success {ns}.data matches 0 store success score #success {ns}.data run function {ns}:utils/has_item {{"item":"pendent"}}
execute if score #success {ns}.data matches 0 store success score #success {ns}.data run function {ns}:utils/has_item {{"item":"pendent_held"}}
execute if score #success {ns}.data matches 0 store success score #success {ns}.data run function {ns}:utils/has_item {{"item":"dragon_necklace"}}
execute if score #success {ns}.data matches 0 store success score #success {ns}.data run function {ns}:utils/has_item {{"item":"dragon_flower_necklace"}}
execute if score #success {ns}.data matches 1 unless entity @s[tag={ns}.has_idol] run tellraw @a[team=aMJ] ["\\n",{{"nbt":"SurvislandSpec","storage":"{ns}:main","interpret":true}},{{"text":" Le joueur "}},{{"selector":"@s","color":"aqua"}},{{"text":" vient de récupérer un idol dans son inventaire !"}}]
execute if score #success {ns}.data matches 1 unless entity @s[tag={ns}.has_idol] run tellraw @a[team=aStaff] ["\\n",{{"nbt":"SurvislandSpec","storage":"{ns}:main","interpret":true}},{{"text":" Le joueur "}},{{"selector":"@s","color":"aqua"}},{{"text":" vient de récupérer un idol dans son inventaire !"}}]
execute if score #success {ns}.data matches 1 unless entity @s[tag={ns}.has_idol] run tellraw @a[team=zSpec] ["\\n",{{"nbt":"SurvislandSpec","storage":"{ns}:main","interpret":true}},{{"text":" Le joueur "}},{{"selector":"@s","color":"aqua"}},{{"text":" vient de récupérer un idol dans son inventaire !"}}]
execute if score #success {ns}.data matches 1 unless entity @s[tag={ns}.has_idol] run tellraw @a[team=zOut] ["\\n",{{"nbt":"SurvislandSpec","storage":"{ns}:main","interpret":true}},{{"text":" Le joueur "}},{{"selector":"@s","color":"aqua"}},{{"text":" vient de récupérer un idol dans son inventaire !"}}]
execute if score #success {ns}.data matches 1 run tag @s add {ns}.has_idol
execute if score #success {ns}.data matches 0 run tag @s remove {ns}.has_idol
""")
	slots: str = "\n".join([
		f"""$execute if items entity @s {slot} *[custom_data~{{{ns}:{{"$(item)":true}}}}] run return 1"""
		for slot in ["container.*", "player.cursor", "armor.*", "weapon.*", "enderchest.*", "player.crafting.*"]
	])
	write_function(f"{ns}:utils/has_item", f"""
# Check if player has item in inventory
{slots}
$execute if data entity @s Inventory[].components."minecraft:custom_data".survisland.$(item) run return 1
return fail
""")

	# utils/pendent_switch
	write_function(f"{ns}:utils/pendent_switch", f"""
# Copy du pendent dans un slot temporaire
setblock 0 5 0 air
setblock 0 5 0 barrel
execute if data entity @s SelectedItem.components{{"minecraft:item_model":"{pendent_held_model}"}} run item replace block 0 5 0 container.0 from entity @s weapon.mainhand
execute if data entity @s equipment.offhand.components{{"minecraft:item_model":"{pendent_model}"}} run item replace block 0 5 0 container.0 from entity @s weapon.offhand

# Inversion du model data du pendent
execute if data entity @s SelectedItem.components{{"minecraft:item_model":"{pendent_held_model}"}} run data modify block 0 5 0 Items[0].components."minecraft:item_model" set value "{pendent_model}"
execute if data entity @s equipment.offhand.components{{"minecraft:item_model":"{pendent_model}"}} run data modify block 0 5 0 Items[0].components."minecraft:item_model" set value "{pendent_held_model}"

# Recopie du pendent dans la main gauche
execute if data entity @s SelectedItem.components{{"minecraft:item_model":"{pendent_held_model}"}} run item replace entity @s weapon.mainhand from block 0 5 0 container.0
execute if data entity @s equipment.offhand.components{{"minecraft:item_model":"{pendent_model}"}} run item replace entity @s weapon.offhand from block 0 5 0 container.0

# Suppression du slot temporaire
setblock 0 5 0 air
""")

	# utils/url
	write_function(f"{ns}:utils/url", """
# Playsound to everyone
execute as @a at @s run playsound entity.experience_orb.pickup ambient @s

# Tellraw with link
$tellraw @a ["\\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lien vers la vidéo d'explication [clique ici]","color":"yellow","click_event":{"action":"open_url","url":"$(url)"},"hover_event":{"action":"show_text","value":"Oui ici !"}}]
""")

