""" Ball and bumper logic of the breakout, running every tick while the balls are in play.

Bounces are done by the vanilla physics of the sulfur cube (bounciness 1, no drag, no gravity).
A bounce shows up as a component of the motion that changed sign since the previous tick,
and the block probed just past the ball on that side is the brick that was hit.
"""
# ruff: noqa: E501
# Imports
import math

from stewbeet import Mem, write_function

from ..shared import LAB
from .colors import COLORS, color_tag

# Constants
MODE: str = "pr_breakout"
""" Suffix of the tags, objectives and fake players of the trial. """

BUMPER_LENGTH: int = 3
""" Blocks of a bumper. """

BUMPER_PERIOD: int = 2
""" Ticks between two steps of a bumper, so 20 / BUMPER_PERIOD blocks per second. """

BALL_SPEED: int = 350
""" Speed of a ball in thousandths of a block per tick, kept by every bounce. """

ZONE_ANGLES: tuple[int, ...] = (-60, -45, -30, -15, 15, 30, 45, 60)
""" Angle from the vertical given by each slice of a bumper, left to right, none of them straight up. """

PROBE_SIDE: str = "0.5"
""" Distance from the ball center to the block probed after a sideways bounce, past its half width of 0.196. """

PROBE_MID: str = "0.2"
""" Height of the ball center above its feet, where sideways probes are made. """

PROBE_ABOVE: str = "0.7"
""" Height above the feet probed after a bounce on a ceiling, past the 0.392 of the ball. """

PROBE_BELOW: str = "-0.3"
""" Height probed under the feet after a bounce on a floor. """


# Functions
def zone_motion(angle: int) -> tuple[int, int]:
	""" Motion given by a bumper slice, along the field and upward

	Args:
		angle: Degrees from the vertical, negative toward the start of the field
	Returns:
		The two components in thousandths of a block per tick, of norm BALL_SPEED

	>>> zone_motion(-60)
	(-303, 175)
	"""
	return round(BALL_SPEED * math.sin(math.radians(angle))), round(BALL_SPEED * math.cos(math.radians(angle)))


def main() -> None:
	""" Write the ball tick, the brick hits, the bumper bounces and the bumper steering. """
	generate_ball_tick()
	generate_hits()
	generate_zones()
	generate_steering()


def generate_ball_tick() -> None:
	""" Write the tick of one ball: read its state once, then look for a death or a bounce. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/play_tick", f"""
execute as @e[type=minecraft:sulfur_cube,tag={tag}.ball] at @s run function {root}/ball_tick

scoreboard players add #{MODE}_clock {ns}.data 1
scoreboard players operation #{MODE}_step {ns}.data = #{MODE}_clock {ns}.data
scoreboard players operation #{MODE}_step {ns}.data %= #{BUMPER_PERIOD} {ns}.data
execute if score #{MODE}_step {ns}.data matches 0 as @a[tag={tag}] run function {root}/steer
""")

	write_function(f"{root}/ball_tick", f"""
# A death or a cleared level earlier in this tick already removed every ball
execute unless score #{MODE}_state {ns}.data matches 2 run return 0

# One entity read per tick, every value then comes from the storage
data modify storage {ns}:{MODE} ball set from entity @s
execute if score #{MODE}_axis {ns}.data matches 0 store result score #{MODE}_u {ns}.data run data get storage {ns}:{MODE} ball.Pos[0] 1000
execute if score #{MODE}_axis {ns}.data matches 1 store result score #{MODE}_u {ns}.data run data get storage {ns}:{MODE} ball.Pos[2] 1000
execute store result score #{MODE}_v {ns}.data run data get storage {ns}:{MODE} ball.Pos[1] 1000
execute if score #{MODE}_axis {ns}.data matches 0 store result score #{MODE}_mu {ns}.data run data get storage {ns}:{MODE} ball.Motion[0] 1000
execute if score #{MODE}_axis {ns}.data matches 1 store result score #{MODE}_mu {ns}.data run data get storage {ns}:{MODE} ball.Motion[2] 1000
execute store result score #{MODE}_mv {ns}.data run data get storage {ns}:{MODE} ball.Motion[1] 1000

execute if score #{MODE}_v {ns}.data < #{MODE}_death_v {ns}.data run return run function {root}/death

# Sideways bounce: the brick hit is on the side the ball was heading to
scoreboard players operation #{MODE}_flip {ns}.data = #{MODE}_mu {ns}.data
scoreboard players operation #{MODE}_flip {ns}.data *= @s {tag}.mu
execute if score #{MODE}_flip {ns}.data matches ..-1 if score #{MODE}_axis {ns}.data matches 0 if score @s {tag}.mu matches 1.. positioned ~{PROBE_SIDE} ~{PROBE_MID} ~ run function {root}/hit_brick
execute if score #{MODE}_flip {ns}.data matches ..-1 if score #{MODE}_axis {ns}.data matches 0 if score @s {tag}.mu matches ..-1 positioned ~-{PROBE_SIDE} ~{PROBE_MID} ~ run function {root}/hit_brick
execute if score #{MODE}_flip {ns}.data matches ..-1 if score #{MODE}_axis {ns}.data matches 1 if score @s {tag}.mu matches 1.. positioned ~ ~{PROBE_MID} ~{PROBE_SIDE} run function {root}/hit_brick
execute if score #{MODE}_flip {ns}.data matches ..-1 if score #{MODE}_axis {ns}.data matches 1 if score @s {tag}.mu matches ..-1 positioned ~ ~{PROBE_MID} ~-{PROBE_SIDE} run function {root}/hit_brick

# Vertical bounce: a ceiling, or on the way down a bumper or the top of a brick
scoreboard players operation #{MODE}_flip {ns}.data = #{MODE}_mv {ns}.data
scoreboard players operation #{MODE}_flip {ns}.data *= @s {tag}.mv
execute if score #{MODE}_flip {ns}.data matches ..-1 if score @s {tag}.mv matches 1.. positioned ~ ~{PROBE_ABOVE} ~ run function {root}/hit_brick
execute if score #{MODE}_flip {ns}.data matches ..-1 if score @s {tag}.mv matches ..-1 run function {root}/bounce_below

scoreboard players operation @s {tag}.mu = #{MODE}_mu {ns}.data
scoreboard players operation @s {tag}.mv = #{MODE}_mv {ns}.data
""")

	write_function(f"{root}/bounce_below", f"""
execute if score #{MODE}_v {ns}.data < #{MODE}_bumper_top {ns}.data run return run function {root}/bumper_hit
execute positioned ~ ~{PROBE_BELOW} ~ run function {root}/hit_brick
""")


def generate_hits() -> None:
	""" Write the brick hit, only breaking the bricks of the color of the ball. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	own_color: str = "\n".join(
		f"execute if score @s {tag}.color matches {index} if block ~ ~ ~ {color_tag(color)} run return run function {root}/break_brick"
		for index, color in enumerate(COLORS)
	)

	write_function(f"{root}/hit_brick", f"""
# Positioned on the probed block, run as the ball that bounced
{own_color}
""")

	write_function(f"{root}/break_brick", f"""
# destroy gives the real break particles and sound, its drop is removed right away
setblock ~ ~ ~ minecraft:air destroy
kill @e[type=minecraft:item,distance=..1.5]
scoreboard players remove #{MODE}_remaining {ns}.data 1
execute if score #{MODE}_remaining {ns}.data matches ..0 run function {root}/level_cleared
""")


def generate_zones() -> None:
	""" Write the bumper bounce: the slice of the bumper under the ball picks the new direction. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	zone_count: int = len(ZONE_ANGLES)
	motions: list[tuple[int, int]] = [zone_motion(angle) for angle in ZONE_ANGLES]
	set_zone: str = "\n".join(
		f"execute if score #{MODE}_zone {ns}.data matches {zone} run scoreboard players set #{MODE}_mu {ns}.data {mu}\n"
		f"execute if score #{MODE}_zone {ns}.data matches {zone} run scoreboard players set #{MODE}_mv {ns}.data {mv}"
		for zone, (mu, mv) in enumerate(motions)
	)

	write_function(f"{root}/bumper_hit", f"""
scoreboard players set #{MODE}_zone {ns}.data -1
execute as @e[type=minecraft:marker,tag={tag}.bumper] run function {root}/measure_bumper
execute if score #{MODE}_zone {ns}.data matches -1 run return 0
function {root}/apply_zone
playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 1.4
""")

	write_function(f"{root}/measure_bumper", f"""
# @s is a bumper, u its first block: the ball above it lands on slice (rel + 500) * {zone_count} / {BUMPER_LENGTH * 1000}
scoreboard players operation #{MODE}_rel {ns}.data = #{MODE}_u {ns}.data
scoreboard players operation #{MODE}_rel {ns}.data -= @s {tag}.u
execute unless score #{MODE}_rel {ns}.data matches -500..{(BUMPER_LENGTH - 1) * 1000 + 500} run return 0
scoreboard players add #{MODE}_rel {ns}.data 500
scoreboard players operation #{MODE}_rel {ns}.data *= #{zone_count} {ns}.data
scoreboard players operation #{MODE}_rel {ns}.data /= #{BUMPER_LENGTH * 1000} {ns}.data
execute if score #{MODE}_rel {ns}.data matches {zone_count}.. run scoreboard players set #{MODE}_rel {ns}.data {zone_count - 1}
scoreboard players operation #{MODE}_zone {ns}.data = #{MODE}_rel {ns}.data
""")

	write_function(f"{root}/apply_zone", f"""
# @s is a ball, sent along the motion of slice #{MODE}_zone
{set_zone}
execute if score #{MODE}_axis {ns}.data matches 0 store result entity @s Motion[0] double 0.001 run scoreboard players get #{MODE}_mu {ns}.data
execute if score #{MODE}_axis {ns}.data matches 1 store result entity @s Motion[2] double 0.001 run scoreboard players get #{MODE}_mu {ns}.data
execute store result entity @s Motion[1] double 0.001 run scoreboard players get #{MODE}_mv {ns}.data
""")


def generate_steering() -> None:
	""" Write the bumper steps, a bumper only entering an empty cell so the bumpers block each other. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/breakout"
	tag: str = f"{ns}.{MODE}"
	free_cell: str = f"align xyz unless entity @e[type=minecraft:sulfur_cube,tag={tag}.ball,dx=0,dy=0,dz=0] positioned ~0.5 ~ ~0.5 if block ~ ~ ~ minecraft:air"

	write_function(f"{root}/steer", f"""
# @s is a player, its left and right keys move its own bumper along the field
scoreboard players set #{MODE}_dir {ns}.data 0
execute if predicate {ns}:input/right run scoreboard players add #{MODE}_dir {ns}.data 1
execute if predicate {ns}:input/left run scoreboard players remove #{MODE}_dir {ns}.data 1
execute if score #{MODE}_dir {ns}.data matches 0 run return 0
execute if score #{MODE}_invert {ns}.data matches 1 run scoreboard players operation #{MODE}_dir {ns}.data *= #-1 {ns}.data
scoreboard players operation #{MODE}_slot {ns}.data = @s {tag}
execute as @e[type=minecraft:marker,tag={tag}.bumper,predicate={ns}:{LAB}/breakout/same_slot] at @s run function {root}/move_bumper
""")

	write_function(f"{root}/move_bumper", f"""
# @s is a bumper standing on its first block, facing along the field
execute if score #{MODE}_dir {ns}.data matches 1 positioned ^ ^ ^{BUMPER_LENGTH} {free_cell} run return run function {root}/step_forward with entity @s data
execute if score #{MODE}_dir {ns}.data matches -1 positioned ^ ^ ^-1 {free_cell} run function {root}/step_backward with entity @s data
""")

	write_function(f"{root}/step_forward", f"""
$setblock ~ ~ ~ $(block)
execute at @s run setblock ~ ~ ~ minecraft:air
execute at @s run tp @s ^ ^ ^1
scoreboard players add @s {tag}.u 1000
""")

	write_function(f"{root}/step_backward", f"""
$setblock ~ ~ ~ $(block)
execute at @s run setblock ^ ^ ^{BUMPER_LENGTH - 1} minecraft:air
execute at @s run tp @s ^ ^ ^-1
scoreboard players remove @s {tag}.u 1000
""")

