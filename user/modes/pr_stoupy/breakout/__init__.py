""" Trial "Casse-briques": four players, one bumper and one ball each, on a vertical field facing them.

The field is a wall of W x H cells whose bottom row holds the bumpers and whose other rows hold the bricks.
A ball only breaks the bricks of the color its player stands on, and bounces off everything else.
When the last ball of a player falls under the bumper row, every ball is taken back and relaunched after a countdown.
Every 15 bricks broken, the ball breaking the last one gets a bonus stacking with the previous ones: half again its speed, or a second ball.
A level is over once no brick of the players' colors is left, the next one being cloned in during its countdown.

Each field is an arena: its corner marker holds the state of the game in its own scores, and its players, balls,
bumpers and screen carry the arena id, so several copies of the field run side by side.
Functions working on an arena load its state in the #pr_breakout_* fake players, then save it back on the corner.
"""
# ruff: noqa: E501
# Imports
import json

from stewbeet import JsonDict, Mem, write_function

from ..shared import (
	LAB,
	ON_START_PAD,
	START_RADIUS,
	STORE_TP,
	TELEPORT,
	copy_state,
	require_players,
	write_match_predicate,
)
from .bonuses import main as generate_bonuses
from .colors import (
	COLORS,
	MULTIBALL,
	SOLO_COLORS,
	color_tag,
	generate_color_tags,
	team_name,
	team_setup_lines,
)
from .example import main as generate_example
from .physics import BUMPER_HEIGHT, BUMPER_LENGTH, BUMPER_PERIOD, MODE, main as generate_physics

# Constants
PLAYERS: int = 4
""" Players of a game, each one standing on a block of its own color. """

LEVEL_BLOCKS: tuple[str, ...] = ("minecraft:iron_block", "minecraft:gold_block", "minecraft:diamond_block")
""" Block placed at the level_block position when each level starts, for command blocks to detect which level to clone in. """

LEVELS: int = len(LEVEL_BLOCKS)
""" Levels to clear before the star is given. """

SETUP_RADIUS: int = 16
""" Radius around a new corner in which the previous corner of the same field is replaced. """

MAX_SIZE: int = 64
""" Most cells measured along the row or up the column of a field, for a frame left open or made of bricks. """

START_DELAY: int = 20
""" Ticks a start waits with fewer players than needed (solo mode), so players reaching the pads a tick apart all get in. """

COUNTDOWN: int = 5
""" Seconds counted down before the balls are launched. """

MESSAGE_TICKS: int = 40
""" Ticks the level title or the death message stays alone on the screen before the countdown. """

STATE: tuple[str, ...] = ("arena", "state", "timer", "level", "clock", "axis", "width", "height", "invert", "death_v", "bumper_top", "remaining", "solo", "broken", "bonus")
""" Scores of the corner marker holding the state of its arena, each one mirrored by a #pr_breakout_<name> fake player. """

BALL_NBT: str = '{Tags:["survisland.pr_breakout.ball"],Size:0,Invulnerable:1b,Silent:1b,PersistenceRequired:1b,Glowing:1b,equipment:{body:{id:"minecraft:stone",count:1}},drop_chances:{body:0.0f},attributes:[{id:"minecraft:gravity",base:0.0d},{id:"minecraft:bounciness",base:1.0d},{id:"minecraft:air_drag_modifier",base:0.0d},{id:"minecraft:friction_modifier",base:0.0d},{id:"minecraft:scale",base:0.8d},{id:"minecraft:movement_speed",base:0.0d}]}'
""" A tiny sulfur cube, bouncing without any loss: gravity, drag and friction are zeroed and every bounce keeps the full speed. """

ZOOM: str = "survisland:pr_breakout_zoom"
""" Movement speed modifier slowing the seated players, only for the slight zoom it gives their view. """

SCREEN_OFFSET: str = "1.5"
""" Blocks between the brick plane and the screen text, toward the players so the bricks never hide it. """


# Classes
class Arena:
	""" Selectors of the arena whose id is in #pr_breakout_arena, shared by every generator of the trial. """
	def __init__(self) -> None:
		ns: str = Mem.ctx.project_id
		tag: str = f"{ns}.{MODE}"
		self.same: str = write_match_predicate(f"{LAB}/breakout/same_arena", {f"{tag}.arena": f"#{MODE}_arena"})
		self.same_slot: str = write_match_predicate(f"{LAB}/breakout/same_slot", {f"{tag}.arena": f"#{MODE}_arena", tag: f"#{MODE}_slot"})
		self.corner: str = f"@e[type=minecraft:marker,tag={tag}.corner,{self.same},limit=1]"
		self.players: str = f"@a[tag={tag},{self.same}]"
		self.balls: str = f"@e[type=minecraft:sulfur_cube,tag={tag}.ball,{self.same}]"

	def screen(self, component: JsonDict | list[JsonDict]) -> str:
		""" Command writing a text component on the screen of the arena. """
		return f"data modify entity @n[type=minecraft:text_display,tag={Mem.ctx.project_id}.{MODE}.screen,{self.same}] text set value {json.dumps(component, ensure_ascii=False)}"


# Functions
def main() -> None:
	""" Write every function of the breakout trial. """
	arena: Arena = Arena()
	generate_color_tags()
	generate_setup(arena)
	generate_arena_state(arena)
	generate_start(arena)
	generate_levels(arena)
	generate_countdown(arena)
	generate_physics(arena.same, arena.same_slot)
	generate_bonuses(arena.players, arena.balls)
	generate_endings(arena)
	generate_example()


def generate_setup(arena: Arena) -> None:
	""" Write the field setup, run once from the bottom left cell of the bumper row. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	objectives: str = "\n".join(f"scoreboard objectives add {tag}.{name} dummy" for name in ("color", "mu", "mv", "u", "speed", "wait", *STATE))

	write_function(f"{root}/here/setup", f"""
# Positioned on the bottom left cell of the field, width and height in blocks, axis along which the field extends
function {root}/objectives
{team_setup_lines()}
execute as @e[type=minecraft:marker,tag={tag}.corner,distance=..{SETUP_RADIUS}] run function {root}/forget_arena

scoreboard players add #{MODE}_arena_counter {ns}.data 1
scoreboard players operation #{MODE}_arena {ns}.data = #{MODE}_arena_counter {ns}.data
scoreboard players set #{MODE}_state {ns}.data 0
scoreboard players set #{MODE}_level {ns}.data 0
$scoreboard players set #{MODE}_width {ns}.data $(width)
$scoreboard players set #{MODE}_height {ns}.data $(height)
$scoreboard players set #{MODE}_invert {ns}.data $(invert)
$data modify storage {ns}:{MODE} axis set value "$(axis)"
scoreboard players set #{MODE}_axis {ns}.data 0
execute if data storage {ns}:{MODE} {{axis:"z"}} run scoreboard players set #{MODE}_axis {ns}.data 1
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function {root}/setup_corner
tellraw @a[distance=..16] {{"text":"Casse-briques : terrain configuré.","color":"green"}}
""")

	write_function(f"{root}/objectives", f"""
scoreboard objectives add {tag} dummy
{objectives}
""")

	write_function(f"{root}/forget_arena", f"""
# @s is the corner of a field set up again: its game, its screen and its bumpers go away with it
function {root}/load_arena
function {root}/stop_arena
kill @e[type=minecraft:text_display,tag={tag}.screen,{arena.same}]
kill @e[type=minecraft:marker,tag={tag}.level_block,{arena.same}]
kill @s
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
function {root}/save_arena
function {root}/place_screen
""")

	write_function(f"{root}/place_screen", f"""
# @s is the corner, at itself: the screen hangs in the middle of the field, on the side of the players (^- with invert:0, ^+ with invert:1)
kill @e[type=minecraft:text_display,tag={tag}.screen,{arena.same}]
execute store result storage {ns}:{MODE} middle.u double 0.5 run scoreboard players remove #{MODE}_width {ns}.data 1
scoreboard players add #{MODE}_width {ns}.data 1
execute store result storage {ns}:{MODE} middle.v double 0.5 run scoreboard players remove #{MODE}_height {ns}.data 1
scoreboard players add #{MODE}_height {ns}.data 1
scoreboard players operation #{MODE}_side {ns}.data = #{MODE}_invert {ns}.data
scoreboard players operation #{MODE}_side {ns}.data *= #2 {ns}.data
execute store result storage {ns}:{MODE} middle.side double {SCREEN_OFFSET} run scoreboard players remove #{MODE}_side {ns}.data 1
execute rotated as @s run function {root}/summon_screen with storage {ns}:{MODE} middle
""")

	write_function(f"{root}/summon_screen", f"""
# Facing the players and parallel to the bricks, so looking up at it never tilts it into them
$execute positioned ^$(side) ^$(v) ^$(u) facing ^$(side) ^ ^ summon minecraft:text_display run function {root}/new_screen
""")

	write_function(f"{root}/new_screen", f"""
tag @s add {tag}.screen
rotate @s ~ ~
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
data merge entity @s {{billboard:"fixed",alignment:"center",background:0,shadow:0b,line_width:400,brightness:{{sky:15,block:15}},transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[3f,3f,3f]}}}}
""")


def generate_arena_state(arena: Arena) -> None:
	""" Write the state copies between a corner and the fake players, and the tick running every arena. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/load_arena", f"""
# @s is a corner
{copy_state(MODE, STATE, to_anchor=False)}
""")

	write_function(f"{root}/save_arena", f"""
# @s is a corner
{copy_state(MODE, STATE, to_anchor=True)}
""")

	write_function(f"{root}/tick", f"""
scoreboard players set #{MODE}_active {ns}.data 0
execute as @e[type=minecraft:marker,tag={tag}.corner] at @s run function {root}/arena_tick
execute if score #{MODE}_active {ns}.data matches 1.. run schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/arena_tick", f"""
# State: 1 countdown, 2 balls in play, 3 level cleared and waiting for next_level, 0 stopped
execute unless score @s {tag}.state matches 1..2 run return 0
function {root}/load_arena
execute as {arena.players} unless predicate {ns}:riding run function {root}/remount
execute if score #{MODE}_state {ns}.data matches 1 run function {root}/countdown_tick
execute if score #{MODE}_state {ns}.data matches 2 run function {root}/play_tick
execute if score #{MODE}_state {ns}.data matches 1..2 run scoreboard players add #{MODE}_active {ns}.data 1
function {root}/save_arena
""")

	write_function(f"{root}/stop_arena", f"""
# The arena loaded in the fake players goes back to rest
kill {arena.balls}
execute as @e[type=minecraft:block_display,tag={tag}.bumper,{arena.same}] at @s run fill ^ ^ ^ ^ ^ ^{BUMPER_LENGTH - 1} minecraft:air replace minecraft:barrier
kill @e[type=minecraft:block_display,tag={tag}.bumper,{arena.same}]
kill @e[type=minecraft:item_display,tag={tag}.seat,{arena.same}]
execute as {arena.players} run function {root}/release_player
scoreboard players set #{MODE}_state {ns}.data 0
""")

	write_function(f"{root}/release_player", f"""
attribute @s minecraft:movement_speed modifier remove {ZOOM}
tag @s remove {tag}
""")

	write_function(f"{root}/remount", f"""
# Sneaking gets a player off its seat, it is put back on right away
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
ride @s mount @e[type=minecraft:item_display,tag={tag}.seat,{arena.same_slot},limit=1]
""")


def generate_start(arena: Arena) -> None:
	""" Write the start, moving the players from the start pads, then enrolling them from left to right with the color under their feet. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	free_player: str = f"tag=!{tag},distance=..{START_RADIUS},{ON_START_PAD},gamemode=!creative,gamemode=!spectator"
	read_color: str = "\n".join(f"execute if block ~ ~-1 ~ {color_tag(color)} run scoreboard players set @s {tag}.color {index}" for index, color in enumerate(COLORS) if color is not MULTIBALL)

	write_function(f"{root}/start", f"""
# Safe to fire every tick: the nearest field starts once idle with {PLAYERS} free players on the start pads
# $(tp) moves each player onto its colored block, read right after, "" to read it under the pad
# $(level_block) is where the block of each level is placed when it starts, relative to the caller, "" for none
execute unless entity @e[type=minecraft:marker,tag={tag}.corner] run return 0
execute if score @n[type=minecraft:marker,tag={tag}.corner] {tag}.state matches 1.. run return 0
execute store result score #{MODE}_free {ns}.data if entity @a[{free_player}]
execute unless score #{MODE}_free {ns}.data matches 1.. run return run scoreboard players set @n[type=minecraft:marker,tag={tag}.corner] {tag}.wait 0
{require_players(f"#{MODE}_free {ns}.data", PLAYERS)}
function {root}/objectives
execute if score #{MODE}_free {ns}.data matches ..{PLAYERS - 1} run scoreboard players add @n[type=minecraft:marker,tag={tag}.corner] {tag}.wait 1
execute if score #{MODE}_free {ns}.data matches ..{PLAYERS - 1} if score @n[type=minecraft:marker,tag={tag}.corner] {tag}.wait matches ..{START_DELAY - 1} run return 0
scoreboard players set @n[type=minecraft:marker,tag={tag}.corner] {tag}.wait 0
execute as @n[type=minecraft:marker,tag={tag}.corner] run function {root}/load_arena

tag @a[{free_player},limit={PLAYERS},sort=nearest] add {tag}.new
{STORE_TP}
execute as @a[tag={tag}.new] at @s run {TELEPORT}

# Slots go from the start of the field to its end, the closest player to the first cell being the Joueur 1
scoreboard players set #{MODE}_slot_counter {ns}.data 0
execute at {arena.corner} as @a[tag={tag}.new,sort=nearest] at @s run function {root}/enroll_player
tag @a remove {tag}.new
execute if entity @a[tag={tag},{arena.same},scores={{{tag}.color=-1}}] run return run function {root}/abort_colorless
execute as {arena.corner} at @s rotated as @s run function {root}/measure_field
execute as {arena.corner} at @s run function {root}/place_screen

# Fewer players than needed only happens in solo mode, where every ball breaks every solo color
scoreboard players set #{MODE}_solo {ns}.data 0
execute if score #{MODE}_free {ns}.data matches ..{PLAYERS - 1} run scoreboard players set #{MODE}_solo {ns}.data 1

execute as @e[type=minecraft:marker,tag={tag}.level_block,{arena.same}] at @s run function {root}/forget_level_block
$data modify storage {ns}:{MODE} level_block set value "$(level_block)"
execute unless data storage {ns}:{MODE} {{level_block:""}} run function {root}/place_level_block with storage {ns}:{MODE}

scoreboard players set #{MODE}_broken {ns}.data 0
scoreboard players set #{MODE}_bonus {ns}.data 0
scoreboard players set #{MODE}_level {ns}.data 1
function {root}/begin_level
execute as {arena.corner} run function {root}/save_arena
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/enroll_player", f"""
scoreboard players add #{MODE}_slot_counter {ns}.data 1
scoreboard players operation @s {tag} = #{MODE}_slot_counter {ns}.data
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
tag @s add {tag}
scoreboard players set @s {tag}.color -1
# The tp may leave the player above its booth, so the first colored block down to 3 blocks under the feet counts
function {root}/read_color
execute if score @s {tag}.color matches -1 positioned ~ ~-1 ~ run function {root}/read_color
execute if score @s {tag}.color matches -1 positioned ~ ~-2 ~ run function {root}/read_color

# Seated for the whole game, so its keys only steer the bumper
# In the middle of its block, raised by the 0.6 a seated player sinks by its vehicle attachment
execute align xz positioned ~0.5 ~0.6 ~0.5 summon minecraft:item_display run function {root}/new_seat
attribute @s minecraft:movement_speed modifier add {ZOOM} -0.2 add_multiplied_total
ride @s mount @n[type=minecraft:item_display,tag={tag}.new_seat]
tag @e[type=minecraft:item_display,tag={tag}.new_seat] remove {tag}.new_seat
""")

	write_function(f"{root}/new_seat", f"""
tag @s add {tag}.seat
tag @s add {tag}.new_seat
scoreboard players operation @s {tag} = #{MODE}_slot_counter {ns}.data
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
""")

	write_function(f"{root}/read_color", f"""
{read_color}
""")

	write_function(f"{root}/measure_field", f"""
# @s is the corner, at and rotated as itself: the field is measured up to its frame at every start, whatever the setup was given
scoreboard players set #{MODE}_width {ns}.data 0
function {root}/measure_row
scoreboard players set #{MODE}_height {ns}.data 1
execute positioned ~ ~1 ~ run function {root}/measure_column
""")

	write_function(f"{root}/measure_row", f"""
# The bumper row is empty up to the frame, but for the barriers of bumpers left over
execute unless block ~ ~ ~ #minecraft:air unless block ~ ~ ~ minecraft:barrier run return 0
scoreboard players add #{MODE}_width {ns}.data 1
execute if score #{MODE}_width {ns}.data matches ..{MAX_SIZE - 1} positioned ^ ^ ^1 run function {root}/measure_row
""")

	write_function(f"{root}/measure_column", f"""
# The first column holds only air and bricks up to the frame
execute unless block ~ ~ ~ #minecraft:air unless block ~ ~ ~ #{ns}:pr_stoupy/breakout/any run return 0
scoreboard players add #{MODE}_height {ns}.data 1
execute if score #{MODE}_height {ns}.data matches ..{MAX_SIZE - 1} positioned ~ ~1 ~ run function {root}/measure_column
""")

	write_function(f"{root}/forget_level_block", """
# The level block of the previous game is taken back with its marker
setblock ~ ~ ~ minecraft:air
kill @s
""")

	write_function(f"{root}/place_level_block", f"""
$execute positioned $(level_block) align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function {root}/new_level_block
""")

	write_function(f"{root}/new_level_block", f"""
tag @s add {tag}.level_block
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
""")

	write_function(f"{root}/abort_colorless", f"""
tellraw {arena.players} {{"text":"Casse-briques : chaque joueur doit se tenir sur un bloc de couleur (béton, laine, terre cuite ou verre teinté).","color":"red"}}
kill @e[type=minecraft:item_display,tag={tag}.seat,{arena.same}]
execute as {arena.players} run function {root}/release_player
""")


def generate_levels(arena: Arena) -> None:
	""" Write the level start: bricks counted, bumpers put back, countdown shown. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	count_cell: str = "\n".join(f"execute if block ~ ~ ~ {color_tag(color)} run return run scoreboard players add #{MODE}_bricks_{color.name} {ns}.data 1" for color in COLORS)
	reset_counts: str = "\n".join(f"scoreboard players set #{MODE}_bricks_{color.name} {ns}.data 0" for color in COLORS)
	sum_solo: str = "\n".join(f"scoreboard players operation #{MODE}_remaining {ns}.data += #{MODE}_bricks_{color.name} {ns}.data" for color in SOLO_COLORS)
	sum_played: str = "\n".join(
		f"execute if entity @a[tag={tag},{arena.same},scores={{{tag}.color={index}}}] run scoreboard players operation #{MODE}_remaining {ns}.data += #{MODE}_bricks_{color.name} {ns}.data"
		for index, color in enumerate(COLORS) if color is not MULTIBALL
	)
	bumper_blocks: str = "\n".join(f'execute if score @s {tag}.color matches {index} run data modify entity @s block_state.Name set value "{color.blocks[0]}"' for index, color in enumerate(COLORS))
	place_level_block: str = "\n".join(
		f"execute if score #{MODE}_level {ns}.data matches {level} at @e[type=minecraft:marker,tag={tag}.level_block,{arena.same}] run setblock ~ ~ ~ {block}"
		for level, block in enumerate(LEVEL_BLOCKS, start=1)
	)
	level_title: list[JsonDict] = [{"text": "Niveau ", "color": "#01FE41"}, {"score": {"name": f"#{MODE}_level", "objective": f"{ns}.data"}, "color": "#01FE41"}, {"text": f"/{LEVELS}", "color": "#01FE41"}]

	write_function(f"{root}/begin_level", f"""
kill {arena.balls}
# The level block lets command blocks clone the bricks of the level in during the countdown, it is taken back at the launch
{place_level_block}
function {root}/place_bumpers
scoreboard players set #{MODE}_state {ns}.data 1
scoreboard players set #{MODE}_timer {ns}.data {COUNTDOWN * 20 + MESSAGE_TICKS}
{arena.screen(level_title)}
""")

	write_function(f"{root}/count_bricks", f"""
# Raster scan of the brick rows at every launch, once the level is cloned in: breaks are then counted down one by one
{reset_counts}
scoreboard players set #{MODE}_scan_v {ns}.data 1
execute at {arena.corner} rotated as {arena.corner} positioned ~ ~1 ~ run function {root}/scan_row
scoreboard players set #{MODE}_remaining {ns}.data 0
execute if score #{MODE}_solo {ns}.data matches 1 run return run function {root}/sum_solo
{sum_played}
""")

	write_function(f"{root}/sum_solo", sum_solo)

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
kill @e[type=minecraft:block_display,tag={tag}.bumper,{arena.same}]
execute store result storage {ns}:{MODE} row.last int 1 run scoreboard players remove #{MODE}_width {ns}.data 1
scoreboard players add #{MODE}_width {ns}.data 1
execute at {arena.corner} rotated as {arena.corner} run function {root}/clear_row with storage {ns}:{MODE} row
execute store result score #{MODE}_spread {ns}.data if entity {arena.players}
scoreboard players operation #{MODE}_spread {ns}.data *= #2 {ns}.data
execute as {arena.players} run function {root}/place_bumper
""")

	write_function(f"{root}/clear_row", """
$fill ^ ^ ^ ^ ^ ^$(last) minecraft:air
""")

	write_function(f"{root}/place_bumper", f"""
# First cell of the bumper of slot k among n players: (2k - 1) * width / 2n - {BUMPER_LENGTH // 2}
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
scoreboard players operation #{MODE}_color {ns}.data = @s {tag}.color
scoreboard players operation #{MODE}_offset {ns}.data = @s {tag}
scoreboard players operation #{MODE}_offset {ns}.data *= #2 {ns}.data
scoreboard players remove #{MODE}_offset {ns}.data 1
scoreboard players operation #{MODE}_offset {ns}.data *= #{MODE}_width {ns}.data
scoreboard players operation #{MODE}_offset {ns}.data /= #{MODE}_spread {ns}.data
execute store result storage {ns}:{MODE} bumper.offset int 1 run scoreboard players remove #{MODE}_offset {ns}.data {BUMPER_LENGTH // 2}
execute at {arena.corner} rotated as {arena.corner} run function {root}/summon_bumper with storage {ns}:{MODE} bumper
""")

	write_function(f"{root}/summon_bumper", f"""
$execute positioned ^ ^ ^$(offset) summon minecraft:block_display run function {root}/new_bumper
""")

	write_function(f"{root}/new_bumper", f"""
tag @s add {tag}.bumper
tp @s ~ ~ ~ ~ ~
scoreboard players operation @s {tag} = #{MODE}_slot {ns}.data
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
scoreboard players operation @s {tag}.color = #{MODE}_color {ns}.data
{bumper_blocks}
# Its model spans the top {BUMPER_HEIGHT} of the {BUMPER_LENGTH} cells in front of it, the barriers under it being what the ball bounces on
data merge entity @s {{teleport_duration:{BUMPER_PERIOD},brightness:{{sky:15,block:15}},transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.5f,{1 - float(BUMPER_HEIGHT)}f,-0.5f],scale:[1f,{BUMPER_HEIGHT}f,{BUMPER_LENGTH}f]}}}}
fill ^ ^ ^ ^ ^ ^{BUMPER_LENGTH - 1} minecraft:barrier
function #bs.position:get_pos {{scale:1000}}
execute if score #{MODE}_axis {ns}.data matches 0 run scoreboard players operation @s {tag}.u = @s bs.pos.x
execute if score #{MODE}_axis {ns}.data matches 1 run scoreboard players operation @s {tag}.u = @s bs.pos.z
""")

	write_function(f"{root}/here/next_level", f"""
# The nearest field takes its balls back and goes on from the countdown, during which its level block gets the level cloned in
execute unless score @n[type=minecraft:marker,tag={tag}.corner] {tag}.state matches 1.. run return fail
execute as @n[type=minecraft:marker,tag={tag}.corner] run function {root}/next_level
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/next_level", f"""
# @s is the corner of the field
function {root}/load_arena
scoreboard players add #{MODE}_level {ns}.data 1
function {root}/begin_level
function {root}/save_arena
""")


def generate_countdown(arena: Arena) -> None:
	""" Write the countdown and the launch of the balls. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	counts: str = "\n".join(
		f"execute if score #{MODE}_timer {ns}.data matches {second * 20} run function {root}/count/{second}"
		for second in range(1, COUNTDOWN + 1)
	)
	ball_blocks: str = "\n".join(f'execute if score #{MODE}_color {ns}.data matches {index} run data modify entity @s equipment.body.id set value "{color.blocks[0]}"' for index, color in enumerate(COLORS))
	ball_teams: str = "\n".join(f"execute if score #{MODE}_color {ns}.data matches {index} run team join {team_name(color)} @s" for index, color in enumerate(COLORS))

	write_function(f"{root}/countdown_tick", f"""
scoreboard players remove #{MODE}_timer {ns}.data 1
{counts}
execute if score #{MODE}_timer {ns}.data matches ..0 run function {root}/launch
""")

	for second in range(1, COUNTDOWN + 1):
		write_function(f"{root}/count/{second}", f"""
{arena.screen({"text": str(second), "color": "#01FE41"})}
execute as {arena.players} at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 {0.8 + 0.1 * (COUNTDOWN - second):.1f}
""")

	write_function(f"{root}/launch", f"""
scoreboard players set #{MODE}_state {ns}.data 2
execute at @e[type=minecraft:marker,tag={tag}.level_block,{arena.same}] run setblock ~ ~ ~ minecraft:air
function {root}/count_bricks
{arena.screen({"text": ""})}
execute as {arena.players} at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 2
execute as {arena.players} run function {root}/spawn_ball
""")

	write_function(f"{root}/spawn_ball", f"""
# @s is a player, its ball appears two blocks above the middle of its bumper
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
scoreboard players operation #{MODE}_color {ns}.data = @s {tag}.color
scoreboard players set #{MODE}_speed {ns}.data 100
execute as @e[type=minecraft:block_display,tag={tag}.bumper,{arena.same_slot}] at @s positioned ^ ^2 ^{(BUMPER_LENGTH - 1) / 2} summon minecraft:sulfur_cube run function {root}/new_ball
""")

	write_function(f"{root}/new_ball", f"""
data merge entity @s {BALL_NBT}
scoreboard players operation @s {tag} = #{MODE}_slot {ns}.data
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
scoreboard players operation @s {tag}.color = #{MODE}_color {ns}.data
{ball_blocks}
{ball_teams}
scoreboard players operation @s {tag}.speed = #{MODE}_speed {ns}.data

# Launched upward along one of the middle slices, left or right at random
execute store result score #{MODE}_zone {ns}.data run random value 2..5
function {root}/apply_zone
scoreboard players operation @s {tag}.mu = #{MODE}_mu {ns}.data
scoreboard players operation @s {tag}.mv = #{MODE}_mv {ns}.data
""")


def generate_endings(arena: Arena) -> None:
	""" Write what ends the balls in play: a death, a cleared level, the last level, or a stop. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	cleared_title: list[JsonDict] = [{"text": "Niveau ", "color": "#01FE41"}, {"score": {"name": f"#{MODE}_level", "objective": f"{ns}.data"}, "color": "#01FE41"}, {"text": " terminé !", "color": "#01FE41"}]

	write_function(f"{root}/death", f"""
# @s is the ball that fell, lost for nothing while its player has another one in play
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
tag @s add {tag}.lost
execute if entity @e[type=minecraft:sulfur_cube,tag={tag}.ball,tag=!{tag}.lost,{arena.same_slot}] run return run kill @s

# Its last ball: every ball of the arena is taken back and relaunched after the countdown
{arena.screen({"text": "Balle perdue !", "color": "#01FE41"})}
kill {arena.balls}
scoreboard players set #{MODE}_state {ns}.data 1
scoreboard players set #{MODE}_timer {ns}.data {COUNTDOWN * 20 + MESSAGE_TICKS}
execute as {arena.players} at @s run playsound minecraft:entity.generic.explode master @s ~ ~ ~ 0.6 1.4
""")

	write_function(f"{root}/level_cleared", f"""
kill {arena.balls}
# Left in place until the next level block replaces it, or the next start takes it back
execute at @e[type=minecraft:marker,tag={tag}.level_block,{arena.same}] run setblock ~ ~ ~ minecraft:redstone_block
execute if score #{MODE}_level {ns}.data matches {LEVELS}.. run return run function {root}/victory
scoreboard players set #{MODE}_state {ns}.data 3
{arena.screen(cleared_title)}
execute as {arena.players} at @s run playsound minecraft:entity.player.levelup master @s
tellraw @a[distance=..64] {{"text":"Casse-briques : niveau terminé, lance /function {root}/here/next_level","color":"gray","italic":true}}
""")

	write_function(f"{root}/victory", f"""
{arena.screen({"text": "Bravo !", "color": "#01FE41"})}
execute as @a[tag={tag},{arena.same},scores={{{tag}=1}},limit=1] at @s run function {ns}:{LAB}/give_star {{trial:"Le casse-briques"}}
function {root}/stop_arena
""")

	write_function(f"{root}/here/stop", f"""
# The nearest field only
execute as @n[type=minecraft:marker,tag={tag}.corner] run function {root}/stop_corner
""")

	write_function(f"{root}/stop_corner", f"""
function {root}/load_arena
function {root}/stop_arena
function {root}/save_arena
""")

	write_function(f"{root}/stop", f"""
# Every field, everywhere
execute as @e[type=minecraft:marker,tag={tag}.corner] run function {root}/stop_corner
schedule clear {root}/tick
""")

