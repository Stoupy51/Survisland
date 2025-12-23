
# ruff: noqa: E501
# Imports
from stewbeet import CUSTOM_ITEM_VANILLA, OVERRIDE_MODEL, JsonDict, Mem

# Constants
TRIBE_CIVILIZATION_ITEMS: list[str] = [
	"astral_powder", "blood", "blue_star", "cyan_crystal", "diamond_meteorite",
	"emerald_meteorite", "green_crystal", "iron_meteorite", "letter", "life_crystal",
	"lunar_compass", "purple_crystal", "sandwich", "yellow_crystal", "zinc_meteorite"
]

# Main function should return a database
def main() -> None:
	""" Add Tribe Civilization items to the database. """
	ns: str = Mem.ctx.project_id

	# Add each basic item
	for item in TRIBE_CIVILIZATION_ITEMS:
		Mem.definitions[item] = {"id": CUSTOM_ITEM_VANILLA}

	# Special cases
	Mem.definitions["gold_fish"] = {"id": "minecraft:golden_apple"}

	# Add horns
	horn_texture: str = f"{ns}:item/horns"
	horn_textures: JsonDict = {"0": horn_texture, "particle": horn_texture}

	Mem.definitions["horns"] = {
		"id": CUSTOM_ITEM_VANILLA,
		"max_stack_size": 1,
		"equippable": {"slot": "head"},
		OVERRIDE_MODEL: {"credit":"Made with Blockbench","textures":horn_textures,"elements":[{"from":[1,0,6],"to":[5,4,10],"rotation":{"angle":22.5,"axis":"z","origin":[1,0,6]},"faces":{"north":{"uv":[12,0,13,1],"texture":"#0"},"east":{"uv":[12,0,13,1],"texture":"#0"},"south":{"uv":[12,0,13,1],"texture":"#0"},"west":{"uv":[12,0,13,1],"texture":"#0"},"up":{"uv":[12,0,13,1],"texture":"#0"},"down":{"uv":[12,0,13,1],"texture":"#0"}}},{"from":[0,4,6.5],"to":[3,7,9.5],"rotation":{"angle":0,"axis":"z","origin":[0,4,7]},"faces":{"north":{"uv":[13,3,16,0],"texture":"#0"},"east":{"uv":[13,3,16,0],"texture":"#0"},"south":{"uv":[13,3,16,0],"texture":"#0"},"west":{"uv":[13,3,16,0],"texture":"#0"},"up":{"uv":[13,3,14,2],"texture":"#0"},"down":{"uv":[13,3,16,0],"texture":"#0"}}},{"from":[0,7,7],"to":[2,10,9],"rotation":{"angle":-22.5,"axis":"z","origin":[0,7,6]},"faces":{"north":{"uv":[11,7,13,4],"texture":"#0"},"east":{"uv":[11,7,13,4],"texture":"#0"},"south":{"uv":[11,7,13,4],"texture":"#0"},"west":{"uv":[11,7,13,4],"texture":"#0"},"up":{"uv":[11,7,12,6],"texture":"#0"},"down":{"uv":[11,7,13,4],"texture":"#0"}}},{"from":[1,9,7.1],"to":[2.5,12,8.9],"rotation":{"angle":-22.5,"axis":"z","origin":[1,9,6]},"faces":{"north":{"uv":[4,10,6,7],"texture":"#0"},"east":{"uv":[4,10,6,7],"texture":"#0"},"south":{"uv":[4,10,6,7],"texture":"#0"},"west":{"uv":[4,10,6,7],"texture":"#0"},"up":{"uv":[4,10,5,9],"texture":"#0"},"down":{"uv":[4,10,6,7],"texture":"#0"}}},{"from":[2,11,7.5],"to":[3,14,8.5],"rotation":{"angle":-22.5,"axis":"z","origin":[2,11,6]},"faces":{"north":{"uv":[5,13,6,10],"texture":"#0"},"east":{"uv":[5,13,6,10],"texture":"#0"},"south":{"uv":[5,13,6,10],"texture":"#0"},"west":{"uv":[5,13,6,10],"texture":"#0"},"up":{"uv":[5,13,6,12],"texture":"#0"},"down":{"uv":[5,13,6,10],"texture":"#0"}}},{"from":[3,13,7.6],"to":[3.8,15,8.4],"rotation":{"angle":0,"axis":"z","origin":[3,13,6]},"faces":{"north":{"uv":[12,14,13,12],"texture":"#0"},"east":{"uv":[12,14,13,12],"texture":"#0"},"south":{"uv":[12,14,13,12],"texture":"#0"},"west":{"uv":[12,14,13,12],"texture":"#0"},"up":{"uv":[12,14,13,13],"texture":"#0"},"down":{"uv":[12,14,13,12],"texture":"#0"}}},{"from":[3,14.5,7.75],"to":[3.5,16.5,8.25],"rotation":{"angle":22.5,"axis":"z","origin":[3,15,6]},"faces":{"north":{"uv":[3,16,4,14],"texture":"#0"},"east":{"uv":[3,16,4,14],"texture":"#0"},"south":{"uv":[3,16,4,14],"texture":"#0"},"west":{"uv":[3,16,4,14],"texture":"#0"},"up":{"uv":[3,16,4,15],"texture":"#0"},"down":{"uv":[3,16,4,14],"texture":"#0"}}},{"from":[11,0,6],"to":[15,4,10],"rotation":{"angle":-22.5,"axis":"z","origin":[15,0,6]},"faces":{"north":{"uv":[13,0,12,1],"texture":"#0"},"east":{"uv":[13,0,12,1],"texture":"#0"},"south":{"uv":[13,0,12,1],"texture":"#0"},"west":{"uv":[13,0,12,1],"texture":"#0"},"up":{"uv":[13,0,12,1],"texture":"#0"},"down":{"uv":[13,0,12,1],"texture":"#0"}}},{"from":[13,4,6.5],"to":[16,7,9.5],"rotation":{"angle":0,"axis":"z","origin":[16,4,7]},"faces":{"north":{"uv":[16,3,13,0],"texture":"#0"},"east":{"uv":[16,3,13,0],"texture":"#0"},"south":{"uv":[16,3,13,0],"texture":"#0"},"west":{"uv":[16,3,13,0],"texture":"#0"},"up":{"uv":[14,3,13,2],"texture":"#0"},"down":{"uv":[16,3,13,0],"texture":"#0"}}},{"from":[14,7,7],"to":[16,10,9],"rotation":{"angle":22.5,"axis":"z","origin":[16,7,6]},"faces":{"north":{"uv":[13,7,11,4],"texture":"#0"},"east":{"uv":[13,7,11,4],"texture":"#0"},"south":{"uv":[13,7,11,4],"texture":"#0"},"west":{"uv":[13,7,11,4],"texture":"#0"},"up":{"uv":[12,7,11,6],"texture":"#0"},"down":{"uv":[13,7,11,4],"texture":"#0"}}},{"from":[13.5,9,7.1],"to":[15,12,8.9],"rotation":{"angle":22.5,"axis":"z","origin":[15,9,6]},"faces":{"north":{"uv":[6,10,4,7],"texture":"#0"},"east":{"uv":[6,10,4,7],"texture":"#0"},"south":{"uv":[6,10,4,7],"texture":"#0"},"west":{"uv":[6,10,4,7],"texture":"#0"},"up":{"uv":[5,10,4,9],"texture":"#0"},"down":{"uv":[6,10,4,7],"texture":"#0"}}},{"from":[13,11,7.5],"to":[14,14,8.5],"rotation":{"angle":22.5,"axis":"z","origin":[14,11,6]},"faces":{"north":{"uv":[6,13,5,10],"texture":"#0"},"east":{"uv":[6,13,5,10],"texture":"#0"},"south":{"uv":[6,13,5,10],"texture":"#0"},"west":{"uv":[6,13,5,10],"texture":"#0"},"up":{"uv":[6,13,5,12],"texture":"#0"},"down":{"uv":[6,13,5,10],"texture":"#0"}}},{"from":[12.2,13,7.6],"to":[13,15,8.4],"rotation":{"angle":0,"axis":"z","origin":[13,13,6]},"faces":{"north":{"uv":[13,14,12,12],"texture":"#0"},"east":{"uv":[13,14,12,12],"texture":"#0"},"south":{"uv":[13,14,12,12],"texture":"#0"},"west":{"uv":[13,14,12,12],"texture":"#0"},"up":{"uv":[13,14,12,13],"texture":"#0"},"down":{"uv":[13,14,12,12],"texture":"#0"}}},{"from":[12.5,14.5,7.75],"to":[13,16.5,8.25],"rotation":{"angle":-22.5,"axis":"z","origin":[13,15,6]},"faces":{"north":{"uv":[4,16,3,14],"texture":"#0"},"east":{"uv":[4,16,3,14],"texture":"#0"},"south":{"uv":[4,16,3,14],"texture":"#0"},"west":{"uv":[4,16,3,14],"texture":"#0"},"up":{"uv":[4,16,3,15],"texture":"#0"},"down":{"uv":[4,16,3,14],"texture":"#0"}}}],"display":{"thirdperson_righthand":{"translation":[-6,0,0]},"thirdperson_lefthand":{"translation":[-6,0,0]},"firstperson_righthand":{"rotation":[0,-45,0],"translation":[0,5,-4.75]},"firstperson_lefthand":{"rotation":[0,-45,0],"translation":[0,5,-4.75]},"gui":{"scale":[0.9,0.9,0.9]},"head":{"translation":[0,10,-2.5]}},"groups":[{"name":"horn","origin":[1,0,0],"color":0,"children":[0,1,2,3,4,5,6]},{"name":"horn","origin":[15,0,0],"color":0,"children":[7,8,9,10,11,12,13]}]}
	}
	Mem.definitions["small_horns"] = {
		"id": CUSTOM_ITEM_VANILLA,
		"max_stack_size": 1,
		"equippable": {"slot": "head"},
		OVERRIDE_MODEL: {"credit":"Made with Blockbench","parent":f"{ns}:item/horns","textures":horn_textures,"display":{"head": {"translation": [0, 10, -4],"scale": [0.75, 0.75, 0.75]}}}
	}

