""" Example field of the breakout, built around a corner to see and test the trial without building it by hand.

Seen from the corner facing along the field, the back wall is on the left (^1) and the players stand on the right (^-1),
which is the side where the right key moves a bumper toward the end of the field (invert:0).
"""
# Imports
from stewbeet import Mem, write_function

from ..shared import LAB
from .colors import COLORS, BrickColor
from .physics import MODE

# Constants
EXAMPLE_COLORS: list[BrickColor] = [color for name in ("red", "light_blue", "lime", "yellow") for color in COLORS if color.name == name]
""" Colors of the four booths from the start of the field to its end, and of the bricks. """

BRICK_ROWS: int = 6
""" Rows of bricks under the empty top row, laid in diagonal stripes of the four colors. """

FRAME_BLOCK: str = "minecraft:smooth_stone"
""" Walls, floor, ceiling and player platform, never a brick since it has no color. """


# Functions
def main() -> None:
	""" Write the example field and the refill of its bricks. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	data: str = f"{ns}.data"
	storage: str = f"{ns}:{MODE} example"
	corner: str = f"@n[type=minecraft:marker,tag={tag}.corner]"

	booths: str = "\n".join(f"""
scoreboard players set #{MODE}_offset {data} {2 * slot - 1}
scoreboard players operation #{MODE}_offset {data} *= #{MODE}_width {data}
execute store result storage {storage}.u int 1 run scoreboard players operation #{MODE}_offset {data} /= #8 {data}
data modify storage {storage}.block set value "{color.blocks[0]}"
function {root}/example/booth with storage {storage}""" for slot, color in enumerate(EXAMPLE_COLORS, start=1))
	pick_brick: str = "\n".join(f"execute if score #{MODE}_pick {data} matches {index} run setblock ~ ~ ~ {color.blocks[0]}" for index, color in enumerate(EXAMPLE_COLORS))

	write_function(f"{root}/here/example", f"""
# Sets up a field here like here/setup, then builds it: every block of the frame, the glass front and the booths is replaced
$function {root}/here/setup {{width:$(width),height:$(height),axis:"$(axis)",invert:0}}
execute as {corner} at @s rotated as @s run function {root}/example/build
execute as {corner} at @s rotated as @s run function {root}/example/bricks
tellraw @a[distance=..32] {{"text":"Casse-briques : terrain d'exemple construit, les joueurs se mettent dans les cabines de couleur.","color":"green"}}
""")

	write_function(f"{root}/here/example_level", f"""
# Refills the bricks of the nearest field, then here/next_level goes on with them
execute as {corner} at @s rotated as @s run function {root}/example/bricks
""")

	write_function(f"{root}/example/build", f"""
# The booths stand 3/4 of the height in front of the field, their floor 2 blocks under its middle so the eyes are level with it
function {root}/load_arena
execute store result storage {storage}.width int 1 run scoreboard players get #{MODE}_width {data}
execute store result storage {storage}.height int 1 run scoreboard players get #{MODE}_height {data}
execute store result storage {storage}.middle int 0.5 run scoreboard players get #{MODE}_width {data}
scoreboard players operation #{MODE}_offset {data} = #{MODE}_height {data}
scoreboard players operation #{MODE}_offset {data} *= #3 {data}
execute store result storage {storage}.front int -1 run scoreboard players operation #{MODE}_offset {data} /= #4 {data}
scoreboard players operation #{MODE}_offset {data} = #{MODE}_height {data}
scoreboard players operation #{MODE}_offset {data} /= #2 {data}
execute store result storage {storage}.floor int 1 run scoreboard players remove #{MODE}_offset {data} 2
function {root}/example/frame with storage {storage}
{booths}
""")

	write_function(f"{root}/example/frame", f"""
$fill ^ ^ ^ ^ ^$(height) ^$(width) minecraft:air
$fill ^1 ^-1 ^-1 ^1 ^$(height) ^$(width) minecraft:polished_blackstone
$fill ^ ^-1 ^-1 ^ ^-1 ^$(width) {FRAME_BLOCK}
$fill ^ ^$(height) ^-1 ^ ^$(height) ^$(width) {FRAME_BLOCK}
$fill ^ ^ ^-1 ^ ^$(height) ^-1 {FRAME_BLOCK}
$fill ^ ^ ^$(width) ^ ^$(height) ^$(width) {FRAME_BLOCK}
$fill ^-1 ^-1 ^-1 ^-1 ^$(height) ^$(width) minecraft:glass

# Platform of the players, with the start command block under its middle
$execute positioned ^$(front) ^$(floor) ^ run fill ^1 ^ ^-1 ^-1 ^ ^$(width) {FRAME_BLOCK}
$execute positioned ^$(front) ^$(floor) ^$(middle) run setblock ~ ~-1 ~ minecraft:repeating_command_block{{auto:1b,Command:"function {root}/start"}}
""")

	write_function(f"{root}/example/booth", """
# A 1x1 glass booth open on top, so a player drops in and cannot jump out
$execute positioned ^$(front) ^$(floor) ^$(u) run fill ^-1 ^1 ^-1 ^1 ^2 ^1 minecraft:glass
$execute positioned ^$(front) ^$(floor) ^$(u) run fill ^ ^1 ^ ^ ^2 ^ minecraft:air
$execute positioned ^$(front) ^$(floor) ^$(u) run setblock ~ ~ ~ $(block)
""")

	write_function(f"{root}/example/bricks", f"""
# @s is a corner: the brick rows are emptied, then the top {BRICK_ROWS} of them under the free top row are filled
function {root}/load_arena
execute store result storage {storage}.last_row int 1 run scoreboard players remove #{MODE}_height {data} 1
execute store result storage {storage}.last_cell int 1 run scoreboard players remove #{MODE}_width {data} 1
scoreboard players add #{MODE}_width {data} 1
execute store result storage {storage}.first_row int 1 run scoreboard players remove #{MODE}_height {data} {BRICK_ROWS}
scoreboard players add #{MODE}_height {data} {BRICK_ROWS + 1}
function {root}/example/fill_bricks with storage {storage}
""")

	write_function(f"{root}/example/fill_bricks", f"""
$fill ^ ^1 ^ ^ ^$(last_row) ^$(last_cell) minecraft:air
scoreboard players set #{MODE}_row {data} 0
$execute positioned ~ ~$(first_row) ~ run function {root}/example/brick_row
""")

	write_function(f"{root}/example/brick_row", f"""
scoreboard players set #{MODE}_cell {data} 0
function {root}/example/brick_cell
scoreboard players add #{MODE}_row {data} 1
execute if score #{MODE}_row {data} matches ..{BRICK_ROWS - 1} positioned ~ ~1 ~ run function {root}/example/brick_row
""")

	write_function(f"{root}/example/brick_cell", f"""
scoreboard players operation #{MODE}_pick {data} = #{MODE}_cell {data}
scoreboard players operation #{MODE}_pick {data} += #{MODE}_row {data}
scoreboard players operation #{MODE}_pick {data} %= #{len(EXAMPLE_COLORS)} {data}
{pick_brick}
scoreboard players add #{MODE}_cell {data} 1
execute if score #{MODE}_cell {data} < #{MODE}_width {data} positioned ^ ^ ^1 run function {root}/example/brick_cell
""")

