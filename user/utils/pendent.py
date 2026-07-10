
# ruff: noqa: E501
# Imports
from stewbeet import Item, Mem, write_function


# Generates the pendent system (inventory changed detection, has_item check, pendent switch)
def main() -> None:
	ns: str = Mem.ctx.project_id

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

