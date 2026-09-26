# ruff: noqa: E501
# Imports
from stewbeet import JsonDict, LootTable, Mem, set_json_encoder

# Constants
PLAYER_HEAD_LOOT_TABLE: str = "survisland:player_head"
""" Loot table giving the head of the entity it runs as, used to copy a player skin onto a mannequin through its profile component. """


# Functions
def main() -> None:
	""" Write the loot table giving the head of "this". """
	json_content: JsonDict = {"pools": [{"rolls": 1, "entries": [{"type": "minecraft:item", "name": "minecraft:player_head", "functions": [{"function": "minecraft:fill_player_head", "entity": "this"}]}]}]}
	Mem.ctx.data[Mem.ctx.project_id].loot_tables["player_head"] = set_json_encoder(LootTable(json_content), max_level=-1)

