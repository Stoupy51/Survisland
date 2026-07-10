
# ruff: noqa: E501
# Imports
from stewbeet import Advancement, Item, JsonDict, Mem, set_json_encoder, write_function


# Generates the right click detection system (advancement, switch case, coord stick)
def main() -> None:
	ns: str = Mem.ctx.project_id

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
execute if score #success {ns}.data matches 0 store success score #success {ns}.data if data entity @s SelectedItem.components."minecraft:custom_data".{ns}.coord_stick run function {ns}:utils/coord_stick
execute if score #success {ns}.data matches 0 store success score #success {ns}.data if data entity @s equipment.offhand.components."minecraft:custom_data".{ns}.coord_stick run function {ns}:utils/coord_stick

# Reset score and tag
scoreboard players reset @s {ns}.right_click
tag @s remove {ns}.temp
""")

	# Coord stick
	write_function(f"{ns}:utils/coord_stick", f"""
# Run relative function on the block in front of the player
function #bs.view:at_aimed_block {{run:"function {ns}:utils/relative",with:{{}}}}
""")

