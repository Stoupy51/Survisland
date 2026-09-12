""" Idols: a necklace worn in the chest slot, a pendent alternating between the hand carrying it and the head wearing it, or both.

Both forms of an idol share one inventory texture whenever the artist sent a single file for them, so the resource pack never carries the same PNG twice.
"""
# ruff: noqa: E501
# Imports
from copy import deepcopy
from dataclasses import dataclass
from pathlib import Path
from typing import Any

from stewbeet import Equipment, Item, ItemModifier, JsonDict, Mem, Texture, set_json_encoder, write_function


# Classes
@dataclass(frozen=True)
class Idol:
	""" One idol, obtainable as a chest-equippable necklace, a handheld pendent, or both. """

	necklace: str = ""
	""" Item id of the chest form, empty when the idol has no necklace. """
	pendent: str = ""
	""" Item id of the carried form, empty when the idol has no pendent. """

	@property
	def held_pendent(self) -> str:
		""" Item id of the worn form, i.e. the pendent once moved to the off hand. """
		return f"{self.pendent}_held"

	def pendent_texture(self, texture_names: set[str]) -> str:
		""" Inventory texture of the carried form, the necklace's own when a single file covers both forms. """
		return self.pendent if self.pendent in texture_names else self.necklace

	def held_pendent_texture(self, texture_names: set[str]) -> str:
		""" Inventory texture of the worn form, the carried one when the artist sent no dedicated art. """
		return self.held_pendent if self.held_pendent in texture_names else self.pendent_texture(texture_names)


# Constants
IDOLS: list[Idol] = [
	Idol(necklace="necklace"),
	Idol(necklace="cursed_necklace"),
	Idol(necklace="dinosaur_necklace"),
	Idol(pendent="pendent"),
	Idol(necklace="necklace_bee_fire",  pendent="pendent_bee_fire"),
	Idol(necklace="necklace_bee_leaf",  pendent="pendent_bee_leaf"),
	Idol(necklace="necklace_bee_water", pendent="pendent_bee_water"),
]
""" Every idol of the game. """

PENDENT_LORE: list[JsonDict] = [{"text": "[Seconde main pour l'équiper]", "italic": False, "color": "gray"}]
""" Tells the player a pendent is worn by moving it to the off hand. """

CARRIED_DISPLAY: JsonDict = {
	"thirdperson_righthand": { "translation": [-1.75, 2, 1.5], "scale": [0.5, 0.5, 0.5] },
	"thirdperson_lefthand": { "scale": [0, 0, 0] },
	"firstperson_righthand": { "translation": [0, 3, 0], "scale": [0.75, 0.75, 0.75] },
	"firstperson_lefthand": { "translation": [0, 3, 0], "scale": [0, 0, 0] },
	"gui": { "translation": [0, 0.5, 0] },
	"fixed": { "translation": [0, 0.75, 0], "scale": [1.25, 1.25, 1.25] }
}
""" Pendent held in the main hand: dangling from the right hand, hidden in the left. """

WORN_DISPLAY: JsonDict = {
	"thirdperson_righthand": { "scale": [0, 0, 0] },
	"thirdperson_lefthand": { "rotation": [68, 0, 0], "translation": [-5.75, 0.5, 6.5], "scale": [0.66, 0.66, 0.66] },
	"firstperson_righthand": { "translation": [0, 3, 0], "scale": [0, 0, 0] },
	"firstperson_lefthand": { "translation": [0, 3, 0], "scale": [0, 0, 0] },
	"head": { "translation": [0, -14.25, -5], "scale": [1.1, 1.1, 1.1] },
	"fixed": { "translation": [0, 0.75, 0], "scale": [1.25, 1.25, 1.25] }
}
""" Pendent moved to the off hand: drawn on the head, hidden in the right hand and in first person. """

SPECTATOR_TEAMS: list[str] = ["aMJ", "aStaff", "zSpec", "zOut"]
""" Teams told when a player gets their first idol. """

HAS_ITEM_SLOTS: list[str] = ["container.*", "player.cursor", "armor.*", "weapon.*", "enderchest.*", "player.crafting.*"]
""" Slots scanned by utils/has_item, completed by an Inventory NBT path for what no slot argument reaches. """


# Functions
def main() -> None:
	""" Item definitions of both forms of every idol. """
	textures_folder: str = Mem.ctx.meta.get("stewbeet", {}).get("textures_folder", "")

	# Keyed by basename like the item models plugin indexes its own textures, so a name resolves wherever it sits in the folder
	texture_names: set[str] = {path.stem for path in Path(textures_folder).rglob("*.png")}

	for idol in IDOLS:
		if idol.necklace:
			make_necklace(idol.necklace)
		if idol.pendent:
			make_pendent(idol, texture_names)


def make_necklace(item_id: str) -> None:
	""" Chest-equippable necklace and the humanoid layer drawn over whoever wears it. """
	ns: str = Mem.ctx.project_id
	textures_folder: str = Mem.ctx.meta.get("stewbeet", {}).get("textures_folder", "")
	Item(
		id=item_id,
		components={
			"max_stack_size": 1,
			"equippable": {
				"slot": "chest",
				"asset_id": f"{ns}:{item_id}",
				"damage_on_hurt": False
			}
		}
	)
	Mem.ctx.assets[ns].textures[f"entity/equipment/humanoid/{item_id}_held"] = Texture(source_path=f"{textures_folder}/idols/{item_id}_held.png")
	Mem.ctx.assets[ns].equipments[item_id] = set_json_encoder(Equipment({"layers": {"humanoid": [{"texture": f"{ns}:{item_id}_held"}]}}), max_level=3)


def make_pendent(idol: Idol, texture_names: set[str]) -> None:
	""" The two forms a pendent alternates between, both named after the carried one. """
	ns: str = Mem.ctx.project_id
	components: JsonDict = {
		"item_name": {"text": idol.pendent.replace("_", " ").title()},
		"lore": PENDENT_LORE,
		"max_stack_size": 64,
		"custom_data": {ns: {"pendent": True}}
	}
	Item(
		id=idol.pendent,
		components=deepcopy(components),
		override_model={
			"parent": "item/handheld",
			"display": CARRIED_DISPLAY,
			"textures": {"layer0": f"{ns}:item/{idol.pendent_texture(texture_names)}"}
		}
	)
	Item(
		id=idol.held_pendent,
		components=deepcopy(components),
		override_model={
			"parent": "item/handheld",
			"display": WORN_DISPLAY,
			"textures": {"layer0": f"{ns}:item/{idol.held_pendent_texture(texture_names)}"}
		}
	)


def generate_pendent_system() -> None:
	""" Datapack side of the idols: the hand switch of every pendent, and the announcement of a first pickup. """
	ns: str = Mem.ctx.project_id
	write_pendent_switch_modifiers()

	# advancements/inventory_changed
	announce: str = "\n".join(
		f"""execute if score #success {ns}.data matches 1 unless entity @s[tag={ns}.has_idol] run tellraw @a[team={team}] ["\\n",{{"nbt":"SurvislandSpec","storage":"{ns}:main","interpret":true}},{{"text":" Le joueur "}},{{"selector":"@s","color":"aqua"}},{{"text":" vient de récupérer un idol dans son inventaire !"}}]"""
		for team in SPECTATOR_TEAMS
	)
	write_function(f"{ns}:advancements/inventory_changed", f"""
# Advancement revoke
advancement revoke @s only {ns}:inventory_changed

# A pendent shows its carried form in the main hand and its worn form in the off hand
execute if data entity @s SelectedItem.components."minecraft:custom_data".{ns}.pendent run item modify entity @s weapon.mainhand {ns}:switch_pendent_state/mainhand
execute if data entity @s equipment.offhand.components."minecraft:custom_data".{ns}.pendent run item modify entity @s weapon.offhand {ns}:switch_pendent_state/offhand

# If has idol in inventory for first time, tell spectators
execute store success score #success {ns}.data run function {ns}:utils/has_item {{"item":"pendent"}}
{announce}
execute if score #success {ns}.data matches 1 run tag @s add {ns}.has_idol
execute if score #success {ns}.data matches 0 run tag @s remove {ns}.has_idol
""")

	# utils/has_item
	slots: str = "\n".join(
		f"""$execute if items entity @s {slot} *[custom_data~{{{ns}:{{"$(item)":true}}}}] run return 1"""
		for slot in HAS_ITEM_SLOTS
	)
	write_function(f"{ns}:utils/has_item", f"""
# Check if player has item in inventory
{slots}
$execute if data entity @s Inventory[].components."minecraft:custom_data".{ns}.$(item) run return 1
return fail
""")


def write_pendent_switch_modifiers() -> None:
	""" One item modifier per hand, flipping whichever pendent that hand holds to the form that hand shows. """
	ns: str = Mem.ctx.project_id
	pendents: list[Idol] = [idol for idol in IDOLS if idol.pendent]
	swaps: dict[str, dict[str, str]] = {
		"mainhand": {Item.from_id(idol.held_pendent).item_model: Item.from_id(idol.pendent).item_model for idol in pendents},
		"offhand":  {Item.from_id(idol.pendent).item_model: Item.from_id(idol.held_pendent).item_model for idol in pendents},
	}
	for slot, models in swaps.items():
		# A list of conditional functions, which beet types as a plain JSON object
		item_modifiers: Any = [
			{
				"function": "minecraft:set_components",
				"components": {"minecraft:item_model": new_model},
				"conditions": [{"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"equipment": {slot: {"components": {"minecraft:item_model": old_model}}}}}]
			}
			for old_model, new_model in models.items()
		]
		Mem.ctx.data[ns].item_modifiers[f"switch_pendent_state/{slot}"] = set_json_encoder(ItemModifier(item_modifiers), max_level=-1)

