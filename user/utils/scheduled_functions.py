
# ruff: noqa: E501
# Imports
from stewbeet import Mem, write_load_file, write_tick_file, write_versioned_function


# Generates the load, tick, second and minute functions
def main() -> None:
	ns: str = Mem.ctx.project_id

	# Add additional objectives and gamerules to the load function
	write_load_file(f"""
# Add objectives
scoreboard objectives add {ns}.id dummy
scoreboard objectives add {ns}.right_click minecraft.used:minecraft.warped_fungus_on_a_stick
scoreboard objectives add {ns}.deathCount deathCount
scoreboard objectives add {ns}.cooldown dummy
scoreboard objectives add {ns}.relative.x dummy
scoreboard objectives add {ns}.relative.y dummy
scoreboard objectives add {ns}.relative.z dummy

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

