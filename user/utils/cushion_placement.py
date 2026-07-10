
# ruff: noqa: E501
# Imports
from stewbeet import Advancement, JsonDict, Mem, set_json_encoder, write_function


# Generates the cushion placement system (raycast placement, sittable interaction, creative punch removal)
def main() -> None:
	ns: str = Mem.ctx.project_id

	# Place function (called by the right click switch case)
	write_function(f"{ns}:cushion/place", f"""
# Remember the player rotation and the used cushion item (keeps the dye color)
data modify storage {ns}:temp Rotation set from entity @s Rotation
data modify storage {ns}:temp Item set from entity @s SelectedItem

# Round the yaw to the nearest 22.5° step (16 possible rotations, computed in half-degrees so a step is the #45 constant)
execute store result score #yaw {ns}.data run data get storage {ns}:temp Rotation[0] 2
scoreboard players add #yaw {ns}.data 22
scoreboard players operation #yaw {ns}.data /= #45 {ns}.data
scoreboard players operation #yaw {ns}.data *= #45 {ns}.data
execute store result storage {ns}:temp Rotation[0] float 0.5 run scoreboard players get #yaw {ns}.data

# Raycast to place the cushion on top of the aimed block
function #bs.view:at_aimed_block {{run:"function {ns}:cushion/place_aimed",with:{{}}}}
""")

	# Placement at the aimed block
	write_function(f"{ns}:cushion/place_aimed", f"""
# Stop if the block above the aimed block is not free
execute align xyz unless block ~ ~1 ~ #minecraft:replaceable run return fail

# Summon the cushion display and its interaction on top of the aimed block
execute align xyz positioned ~.5 ~1 ~.5 summon item_display run function {ns}:cushion/on_new_display
execute align xyz positioned ~.5 ~1 ~.5 summon interaction run function {ns}:cushion/on_new_entity
""")

	# Setup of the item display
	write_function(f"{ns}:cushion/on_new_display", f"""
# Add the cushion tag
tag @s add {ns}.cushion

# Show the used cushion item (keeps the dye color) and copy the player yaw
data modify entity @s item set from storage {ns}:temp Item
data modify entity @s Rotation[0] set from storage {ns}:temp Rotation[0]

# Move the model up so the cushion lies on the ground (model is centered on the entity)
data modify entity @s transformation.translation[1] set value 0.5f
""")

	# Setup of the interaction (chair tag to reuse the sitting system)
	write_function(f"{ns}:cushion/on_new_entity", f"""
# Add the cushion tag, and the chair tag to reuse the sitting system
tag @s add {ns}.cushion
tag @s add {ns}.chair

# Modify rotation and size
data modify entity @s Rotation set from storage {ns}:temp Rotation
data modify entity @s height set value 0.25f
data modify entity @s width set value 0.9f

# Playsound
playsound block.wool.place block @a[distance=..20]
particle happy_villager ~ ~ ~ 0.25 0.0 0.25 0 100
""")

	# Advancement triggered when a creative player punches a cushion interaction
	# (26.x entity predicates are maps of sub-predicates, e.g. "type_specific/player")
	json_content: JsonDict = {"criteria":{"requirement":{"trigger":"minecraft:player_hurt_entity","conditions":{"player":{"type_specific/player":{"gamemode":["creative"]}},"entity":{"entity_type":"minecraft:interaction","nbt":f'{{Tags:["{ns}.cushion"]}}'}}}},"rewards":{"function":f"{ns}:cushion/punch_adv"}}
	Mem.ctx.data[ns].advancements["cushion_punch"] = set_json_encoder(Advancement(json_content), max_level=-1)
	write_function(f"{ns}:cushion/punch_adv", f"""
# Advancement revoke
advancement revoke @s only {ns}:cushion_punch

# Add temporary tag and find the punched cushion (the one whose last attacker is this player)
tag @s add {ns}.temp
execute as @e[type=interaction,tag={ns}.cushion,distance=..50] run function {ns}:cushion/compare_attacker

# Remove temporary tag
tag @s remove {ns}.temp
""")

	# Compare the attacker with the player, and kill the cushion if it matches
	write_function(f"{ns}:cushion/compare_attacker", f"""
# Stop if this cushion's last attacker is not the player
scoreboard players set #is_attacker {ns}.data 0
execute on attacker if entity @s[tag={ns}.temp] run scoreboard players set #is_attacker {ns}.data 1
execute if score #is_attacker {ns}.data matches 0 run return fail

# If it's the attacker, kill the cushion display and the interaction
execute at @s run playsound block.wool.break block @a[distance=..20]
execute at @s run particle poof ~ ~.1 ~ 0.2 0.05 0.2 0.01 20
execute at @s run kill @e[type=item_display,tag={ns}.cushion,distance=..0.1]
kill @s
""")

