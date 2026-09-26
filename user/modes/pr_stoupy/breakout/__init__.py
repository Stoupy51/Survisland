""" Trial "Casse-briques": four players, one bumper and one ball each, on a vertical field facing them.

The field is a wall of W x H cells whose bottom row holds the bumpers and whose other rows hold the bricks.
A ball only breaks the bricks of the color its player stands on, and bounces off everything else.
When a ball falls under the bumper row, every ball is taken back and relaunched after a countdown.
A level is over once no brick of the players' colors is left, the next one is cloned in by hand.
"""
# ruff: noqa: E501
# Imports
import json

from stewbeet import JsonDict, Mem, Predicate, set_json_encoder, write_function

from ..shared import LAB, crt_text
from .colors import COLORS, color_tag, generate_color_tags, team_name, team_setup_lines
from .physics import BUMPER_LENGTH, MODE, main as generate_physics

# Constants
PLAYERS: int = 4
""" Players of a game, each one standing on a block of its own color. """

LEVELS: int = 3
""" Levels to clear before the star is given. """

START_RADIUS: int = 8
""" Radius around the start command block where the players are taken. """

COUNTDOWN: int = 5
""" Seconds counted down before the balls are launched. """

MESSAGE_TICKS: int = 40
""" Ticks the level title or the death message stays alone on the screen before the countdown. """

BALL_NBT: str = '{Tags:["survisland.pr_breakout.ball"],Size:0,Invulnerable:1b,Silent:1b,PersistenceRequired:1b,Glowing:1b,equipment:{body:{id:"minecraft:stone",count:1}},drop_chances:{body:0.0f},attributes:[{id:"minecraft:gravity",base:0.0d},{id:"minecraft:bounciness",base:1.0d},{id:"minecraft:air_drag_modifier",base:0.0d},{id:"minecraft:friction_modifier",base:0.0d},{id:"minecraft:scale",base:0.8d},{id:"minecraft:movement_speed",base:0.0d}]}'
""" A tiny sulfur cube, bouncing without any loss: gravity, drag and friction are zeroed and every bounce keeps the full speed. """


# Functions
def screen(component: JsonDict | list[JsonDict]) -> str:
	""" Command writing a text component on the screen of the field. """
	return f"data modify entity @n[type=minecraft:text_display,tag={Mem.ctx.project_id}.{MODE}.screen] text set value {json.dumps(component, ensure_ascii=False)}"


def main() -> None:
	""" Write every function of the breakout trial. """
	ns: str = Mem.ctx.project_id
	slot: JsonDict = {"type": "minecraft:score", "target": {"type": "minecraft:fixed", "name": f"#{MODE}_slot"}, "score": f"{ns}.data"}
	same_slot: JsonDict = {"condition": "minecraft:entity_scores", "entity": "this", "scores": {f"{ns}.{MODE}": {"min": slot, "max": slot}}}
	Mem.ctx.data[ns].predicates[f"{LAB}/breakout/same_slot"] = set_json_encoder(Predicate(same_slot), max_level=-1)

	generate_color_tags()
	generate_setup()
	generate_start()
	generate_levels()
	generate_countdown()
	generate_physics()
	generate_endings()


def generate_setup() -> None:
	""" Write the field setup, run once from the bottom left cell of the bumper row. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/here/setup", f"""
# Positioned on the bottom left cell of the field, width and height in blocks, axis along which the field extends
$scoreboard players set #{MODE}_width {ns}.data $(width)
$scoreboard players set #{MODE}_height {ns}.data $(height)
$scoreboard players set #{MODE}_invert {ns}.data $(invert)
$data modify storage {ns}:{MODE} axis set value "$(axis)"
scoreboard players set #{MODE}_axis {ns}.data 0
execute if data storage {ns}:{MODE} {{axis:"z"}} run scoreboard players set #{MODE}_axis {ns}.data 1

scoreboard objectives add {tag} dummy
scoreboard objectives add {tag}.color dummy
scoreboard objectives add {tag}.mu dummy
scoreboard objectives add {tag}.mv dummy
scoreboard objectives add {tag}.u dummy
{team_setup_lines()}

kill @e[type=minecraft:marker,tag={tag}.corner]
kill @e[type=minecraft:text_display,tag={tag}.screen]
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function {root}/setup_corner
tellraw @a[distance=..16] {{"text":"Casse-briques : terrain configuré.","color":"green"}}
""")

	write_function(f"{root}/setup_corner", f"""
tag @s add {tag}.corner

# Facing along the field, so ^ ^ ^n is the n-th cell of a row
execute if score #{MODE}_axis {ns}.data matches 0 run rotate @s -90 0
execute if score #{MODE}_axis {ns}.data matches 1 run rotate @s 0 0

function #bs.position:get_pos {{scale:1000}}
scoreboard players operation #{MODE}_death_v {ns}.data = @s bs.pos.y
scoreboard players add #{MODE}_death_v {ns}.data 500
scoreboard players operation #{MODE}_bumper_top {ns}.data = @s bs.pos.y
scoreboard players add #{MODE}_bumper_top {ns}.data 1300

# The screen hangs in the middle of the field
execute store result storage {ns}:{MODE} middle.u int 0.5 run scoreboard players get #{MODE}_width {ns}.data
execute store result storage {ns}:{MODE} middle.v int 0.5 run scoreboard players get #{MODE}_height {ns}.data
execute rotated as @s run function {root}/summon_screen with storage {ns}:{MODE} middle
""")

	write_function(f"{root}/summon_screen", f"""
$execute positioned ^ ^$(v) ^$(u) summon minecraft:text_display run function {root}/new_screen
""")

	write_function(f"{root}/new_screen", f"""
tag @s add {tag}.screen
data merge entity @s {{billboard:"center",alignment:"center",background:0,shadow:0b,line_width:400,brightness:{{sky:15,block:15}},transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[3f,3f,3f]}}}}
{screen({"text": ""})}
""")


def generate_start() -> None:
	""" Write the start, enrolling the players from left to right and reading the color under their feet. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	free_player: str = f"tag=!{tag},distance=..{START_RADIUS},gamemode=!creative,gamemode=!spectator"
	read_color: str = "\n".join(f"execute if block ~ ~-1 ~ {color_tag(color)} run scoreboard players set @s {tag}.color {index}" for index, color in enumerate(COLORS))

	write_function(f"{root}/start", f"""
# Safe to fire every tick: one game at a time, on a configured field, with {PLAYERS} free players around
execute if score #{MODE}_state {ns}.data matches 1.. run return 0
execute unless entity @e[type=minecraft:marker,tag={tag}.corner] run return 0
execute store result score #{MODE}_free {ns}.data if entity @a[{free_player}]
execute if score #{MODE}_free {ns}.data matches ..{PLAYERS - 1} run return 0

# Slots go from the start of the field to its end, the closest player to the first cell being the Joueur 1
tag @a[{free_player},limit={PLAYERS},sort=nearest] add {tag}.new
scoreboard players set #{MODE}_slot_counter {ns}.data 0
execute at @e[type=minecraft:marker,tag={tag}.corner,limit=1] as @a[tag={tag}.new,sort=nearest] at @s run function {root}/enroll_player
tag @a remove {tag}.new

execute if entity @a[tag={tag},scores={{{tag}.color=-1}}] run return run function {root}/abort_colorless

scoreboard players set #{MODE}_level {ns}.data 1
function {root}/begin_level
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/enroll_player", f"""
scoreboard players add #{MODE}_slot_counter {ns}.data 1
scoreboard players operation @s {tag} = #{MODE}_slot_counter {ns}.data
tag @s add {tag}
scoreboard players set @s {tag}.color -1
{read_color}
""")

	write_function(f"{root}/abort_colorless", f"""
tellraw @a[tag={tag}] {{"text":"Casse-briques : chaque joueur doit se tenir sur un bloc de couleur (béton, laine, terre cuite ou verre teinté).","color":"red"}}
tag @a remove {tag}
""")


def generate_levels() -> None:
	""" Write the level start: bricks counted, bumpers put back, countdown shown. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	corner: str = f"@e[type=minecraft:marker,tag={tag}.corner,limit=1]"
	count_cell: str = "\n".join(f"execute if block ~ ~ ~ {color_tag(color)} run return run scoreboard players add #{MODE}_bricks_{color.name} {ns}.data 1" for color in COLORS)
	reset_counts: str = "\n".join(f"scoreboard players set #{MODE}_bricks_{color.name} {ns}.data 0" for color in COLORS)
	sum_played: str = "\n".join(
		f"execute if entity @a[tag={tag},scores={{{tag}.color={index}}}] run scoreboard players operation #{MODE}_remaining {ns}.data += #{MODE}_bricks_{color.name} {ns}.data"
		for index, color in enumerate(COLORS)
	)
	bumper_blocks: str = "\n".join(f'execute if score @s {tag}.color matches {index} run data modify entity @s data.block set value "{color.blocks[0]}"' for index, color in enumerate(COLORS))
	draw_cells: str = "\n".join(f"$setblock ^ ^ ^{cell} $(block)" for cell in range(BUMPER_LENGTH))

	write_function(f"{root}/begin_level", f"""
kill @e[type=minecraft:sulfur_cube,tag={tag}.ball]
function {root}/count_bricks
function {root}/place_bumpers
scoreboard players set #{MODE}_state {ns}.data 1
scoreboard players set #{MODE}_timer {ns}.data {COUNTDOWN * 20 + MESSAGE_TICKS}
{screen([{"text": "Niveau ", "color": "#01FE41"}, {"score": {"name": f"#{MODE}_level", "objective": f"{ns}.data"}, "color": "#01FE41"}, {"text": f"/{LEVELS}", "color": "#01FE41"}])}
""")

	write_function(f"{root}/count_bricks", f"""
# Raster scan of the brick rows, once per level: breaks are then counted down one by one
{reset_counts}
scoreboard players set #{MODE}_scan_v {ns}.data 1
execute at {corner} rotated as {corner} positioned ~ ~1 ~ run function {root}/scan_row
scoreboard players set #{MODE}_remaining {ns}.data 0
{sum_played}
""")

	write_function(f"{root}/scan_row", f"""
scoreboard players set #{MODE}_scan_u {ns}.data 0
function {root}/scan_cell
scoreboard players add #{MODE}_scan_v {ns}.data 1
execute if score #{MODE}_scan_v {ns}.data < #{MODE}_height {ns}.data positioned ~ ~1 ~ run function {root}/scan_row
""")

	write_function(f"{root}/scan_cell", f"""
execute if block ~ ~ ~ #{ns}:pr_stoupy/breakout/any run function {root}/count_cell
scoreboard players add #{MODE}_scan_u {ns}.data 1
execute if score #{MODE}_scan_u {ns}.data < #{MODE}_width {ns}.data positioned ^ ^ ^1 run function {root}/scan_cell
""")

	write_function(f"{root}/count_cell", count_cell)

	write_function(f"{root}/place_bumpers", f"""
# The bumper row is emptied, then each player gets its bumper back, spread evenly along the row
kill @e[type=minecraft:marker,tag={tag}.bumper]
execute store result storage {ns}:{MODE} row.last int 1 run scoreboard players remove #{MODE}_width {ns}.data 1
scoreboard players add #{MODE}_width {ns}.data 1
execute at {corner} rotated as {corner} run function {root}/clear_row with storage {ns}:{MODE} row
execute as @a[tag={tag}] run function {root}/place_bumper
""")

	write_function(f"{root}/clear_row", """
$fill ^ ^ ^ ^ ^ ^$(last) minecraft:air
""")

	write_function(f"{root}/place_bumper", f"""
# First cell of the bumper of slot k: (2k - 1) * width / {2 * PLAYERS} - {BUMPER_LENGTH // 2}
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
scoreboard players operation #{MODE}_color {ns}.data = @s {tag}.color
scoreboard players operation #{MODE}_offset {ns}.data = @s {tag}
scoreboard players operation #{MODE}_offset {ns}.data *= #2 {ns}.data
scoreboard players remove #{MODE}_offset {ns}.data 1
scoreboard players operation #{MODE}_offset {ns}.data *= #{MODE}_width {ns}.data
scoreboard players operation #{MODE}_offset {ns}.data /= #{2 * PLAYERS} {ns}.data
execute store result storage {ns}:{MODE} bumper.offset int 1 run scoreboard players remove #{MODE}_offset {ns}.data {BUMPER_LENGTH // 2}
execute at {corner} rotated as {corner} run function {root}/summon_bumper with storage {ns}:{MODE} bumper
""")

	write_function(f"{root}/summon_bumper", f"""
$execute positioned ^ ^ ^$(offset) summon minecraft:marker run function {root}/new_bumper
""")

	write_function(f"{root}/new_bumper", f"""
tag @s add {tag}.bumper
tp @s ~ ~ ~ ~ ~
scoreboard players operation @s {tag} = #{MODE}_slot {ns}.data
scoreboard players operation @s {tag}.color = #{MODE}_color {ns}.data
{bumper_blocks}
function #bs.position:get_pos {{scale:1000}}
execute if score #{MODE}_axis {ns}.data matches 0 run scoreboard players operation @s {tag}.u = @s bs.pos.x
execute if score #{MODE}_axis {ns}.data matches 1 run scoreboard players operation @s {tag}.u = @s bs.pos.z
function {root}/draw_bumper with entity @s data
""")

	write_function(f"{root}/draw_bumper", draw_cells)

	write_function(f"{root}/next_level", f"""
# To call once the next level is cloned in: the balls are taken back and the game goes on from the countdown
execute unless score #{MODE}_state {ns}.data matches 1.. run return fail
scoreboard players add #{MODE}_level {ns}.data 1
title @a[tag={tag}] times 10 40 10
title @a[tag={tag}] subtitle {json.dumps([{"text": "Prochain niveau : ", "color": "gray"}, {"score": {"name": f"#{MODE}_level", "objective": f"{ns}.data"}, "color": "aqua"}, {"text": f"/{LEVELS}", "color": "aqua"}], ensure_ascii=False)}
title @a[tag={tag}] title {json.dumps({"text": ""})}
function {root}/begin_level
schedule function {root}/tick 1t replace
""")


def generate_countdown() -> None:
	""" Write the tick of the game, the countdown and the launch of the balls. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	counts: str = "\n".join(
		f"execute if score #{MODE}_timer {ns}.data matches {second * 20} run function {root}/count/{second}"
		for second in range(1, COUNTDOWN + 1)
	)
	ball_blocks: str = "\n".join(f'execute if score #{MODE}_color {ns}.data matches {index} run data modify entity @s equipment.body.id set value "{color.blocks[0]}"' for index, color in enumerate(COLORS))
	ball_teams: str = "\n".join(f"execute if score #{MODE}_color {ns}.data matches {index} run team join {team_name(color)} @s" for index, color in enumerate(COLORS))

	write_function(f"{root}/tick", f"""
# State: 1 countdown, 2 balls in play, 3 level cleared and waiting for next_level, 0 stopped
execute if score #{MODE}_state {ns}.data matches 1 run function {root}/countdown_tick
execute if score #{MODE}_state {ns}.data matches 2 run function {root}/play_tick
execute if score #{MODE}_state {ns}.data matches 1..2 run schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/countdown_tick", f"""
scoreboard players remove #{MODE}_timer {ns}.data 1
{counts}
execute if score #{MODE}_timer {ns}.data matches ..0 run function {root}/launch
""")

	for second in range(1, COUNTDOWN + 1):
		write_function(f"{root}/count/{second}", f"""
{screen({"text": str(second), "color": "#01FE41"})}
title @a[tag={tag}] times 0 15 5
title @a[tag={tag}] title {crt_text(str(second))}
execute as @a[tag={tag}] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 {0.8 + 0.1 * (COUNTDOWN - second):.1f}
""")

	write_function(f"{root}/launch", f"""
scoreboard players set #{MODE}_state {ns}.data 2
{screen({"text": ""})}
title @a[tag={tag}] title {crt_text("GO !")}
execute as @a[tag={tag}] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 2
execute as @a[tag={tag}] run function {root}/spawn_ball
""")

	write_function(f"{root}/spawn_ball", f"""
# @s is a player, its ball appears two blocks above the middle of its bumper
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
scoreboard players operation #{MODE}_color {ns}.data = @s {tag}.color
execute as @e[type=minecraft:marker,tag={tag}.bumper,predicate={ns}:{LAB}/breakout/same_slot] at @s positioned ^ ^2 ^{BUMPER_LENGTH // 2} summon minecraft:sulfur_cube run function {root}/new_ball
""")

	write_function(f"{root}/new_ball", f"""
data merge entity @s {BALL_NBT}
scoreboard players operation @s {tag} = #{MODE}_slot {ns}.data
scoreboard players operation @s {tag}.color = #{MODE}_color {ns}.data
{ball_blocks}
{ball_teams}

# Launched upward along one of the middle slices, left or right at random
execute store result score #{MODE}_zone {ns}.data run random value 2..5
function {root}/apply_zone
scoreboard players operation @s {tag}.mu = #{MODE}_mu {ns}.data
scoreboard players operation @s {tag}.mv = #{MODE}_mv {ns}.data
""")


def generate_endings() -> None:
	""" Write what ends the balls in play: a death, a cleared level, the last level, or a stop. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	death_messages: str = "\n".join(
		f"execute if score @s {tag}.color matches {index} run {screen([{'text': f'Joueur {color.display}', 'color': color.team_color}, {'text': ' est mort !', 'color': '#01FE41'}])}"
		for index, color in enumerate(COLORS)
	)

	write_function(f"{root}/death", f"""
# @s is the ball that fell: every ball is taken back and relaunched after the countdown
{death_messages}
kill @e[type=minecraft:sulfur_cube,tag={tag}.ball]
scoreboard players set #{MODE}_state {ns}.data 1
scoreboard players set #{MODE}_timer {ns}.data {COUNTDOWN * 20 + MESSAGE_TICKS}
execute as @a[tag={tag}] at @s run playsound minecraft:entity.generic.explode master @s ~ ~ ~ 0.6 1.4
""")

	write_function(f"{root}/level_cleared", f"""
kill @e[type=minecraft:sulfur_cube,tag={tag}.ball]
execute if score #{MODE}_level {ns}.data matches {LEVELS}.. run return run function {root}/victory
scoreboard players set #{MODE}_state {ns}.data 3
{screen([{"text": "Niveau ", "color": "#01FE41"}, {"score": {"name": f"#{MODE}_level", "objective": f"{ns}.data"}, "color": "#01FE41"}, {"text": " terminé !", "color": "#01FE41"}])}
execute as @a[tag={tag}] at @s run playsound minecraft:entity.player.levelup master @s
tellraw @a[distance=..64] {{"text":"Casse-briques : niveau terminé, clone le suivant puis lance /function {root}/next_level","color":"gray","italic":true}}
""")

	write_function(f"{root}/victory", f"""
{screen({"text": "Bravo !", "color": "#01FE41"})}
execute as @a[tag={tag},scores={{{tag}=1}},limit=1] at @s run function {ns}:{LAB}/give_star {{trial:"Le casse-briques"}}
function {root}/stop
""")

	write_function(f"{root}/stop", f"""
kill @e[type=minecraft:sulfur_cube,tag={tag}.ball]
kill @e[type=minecraft:marker,tag={tag}.bumper]
tag @a remove {tag}
scoreboard players set #{MODE}_state {ns}.data 0
schedule clear {root}/tick
""")

