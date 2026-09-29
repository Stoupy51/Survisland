""" Trial "Orbite": one to four players in a room pushed toward a black hole painted on a wall, over three rounds.

Star fragments circle around the hole marker on three rings, one flat and two upright. A player picks one up by touching or clicking it
and banks it at the collector, against the push of the hole, which never stops while the game runs.
A player falling into the hole is detected by a command block of the room, which calls swallow on it:
back above the hole marker, and the fragments it carried return to orbit.
Each player stepping on a start pad joins at once and the pad disappears until the game ends, the first one starts round 1.
From the second round phantoms join, and in the third some of them steal fragments and dive into the hole with them.
A round is won once all its fragments are banked and all its phantoms are dead.

Each room is an arena anchored on its hole marker, which holds the state of the game in its own scores.
The other markers, the players, the fragments and the phantoms carry the arena id, so several copies of the room run side by side.
"""
# ruff: noqa: E501
# Imports
import math
from dataclasses import dataclass

from stewbeet import Advancement, JsonDict, Mem, set_json_encoder, write_function

from .shared import (
	LAB,
	ON_START_PAD,
	START_PAD_BLOCKS,
	START_RADIUS,
	copy_state,
	crt_text,
	write_match_predicate,
)

# Constants
MODE: str = "pr_orbit"
""" Suffix of the tags, objectives and fake players of the trial. """

HOLE_RADIUS: int = 16
""" Radius around a new hole marker in which the previous hole of the same room is replaced, keeping its arena. """

PICKUP_RADIUS: str = "1.6"
""" Distance at which a player picks up a fragment. """

BANK_RADIUS: int = 3
""" Distance to the collector at which carried fragments are banked. """

PULL_PERIOD: int = 4
""" Ticks between two pushes, each one being a player_motion launch along the facing of the hole marker. """

PAD_OFFSETS: tuple[str, ...] = ("~ ~-1 ~", "~0.3 ~-1 ~0.3", "~-0.3 ~-1 ~0.3", "~0.3 ~-1 ~-0.3", "~-0.3 ~-1 ~-0.3")
""" Points under a player where its start pad is looked for: the center, then the corners of its hitbox. """

PLAYER_GRAVITY: str = "0.01"
""" Gravity of the players during the trial, vanilla being 0.08. """

PHANTOM_PUSH: int = 6000
""" Strength of the shove toward the hole given by a phantom hit, in ten thousandths of a block per tick. """

THIEF_PERIOD: int = 200
""" Ticks between two thefts attempts of a thief phantom. """

THIEF_SPEED: str = "0.18"
""" Blocks per tick of a thief diving into the hole. """

BREAK_TICKS: int = 100
""" Ticks of rest between two rounds. """

STATE: tuple[str, ...] = ("arena", "state", "round", "banked", "required", "pull", "timer", "clock")
""" Scores of the hole marker holding the state of its arena, each one mirrored by a #pr_orbit_<name> fake player. """

MARKERS: tuple[str, ...] = ("collector",)
""" Markers of a room besides its hole, each one joining the arena of the nearest hole when placed. """

ROCK_BLOCKS: tuple[str, ...] = ("minecraft:blackstone", "minecraft:blackstone", "minecraft:basalt", "minecraft:deepslate", "minecraft:tuff")
""" Blocks a rock is made of, one drawn at random for each block, a repeated one coming up more often. """

ROCK_RADII: dict[str, int] = {"tiny": 1, "small": 2, "medium": 3, "large": 4, "huge": 5}
""" Radius in blocks of each rock size, placed by here/rock/<size>. """


# Classes
@dataclass(frozen=True)
class Ring:
	""" One orbit of the fragments around the hole marker. """
	radius: int
	""" Distance to the center, in blocks. """
	height: int
	""" Height above the center, in blocks. """
	speed: int
	""" Degrees turned per tick, negative for the other way round (positive only on a vertical ring). """
	vertical_yaw: int | None = None
	""" Yaw of the vertical plane the ring turns in, None for a horizontal ring. """

	def rotation(self, angle: int) -> str:
		""" Macro arguments of new_fragment putting a fragment at an angle of the ring, 0 being the top of a vertical ring

		>>> Ring(radius=5, height=0, speed=2, vertical_yaw=90).rotation(270)
		'yaw:270,pitch:0,half:1'
		"""
		if self.vertical_yaw is None:
			return f"yaw:{angle},pitch:0,half:0"
		if angle < 180:
			return f"yaw:{self.vertical_yaw},pitch:{angle - 90},half:0"
		return f"yaw:{self.vertical_yaw + 180},pitch:{270 - angle},half:1"


@dataclass(frozen=True)
class Round:
	""" Content and difficulty of one round. """
	fragments: int
	""" Fragments to bank, spread over the rings. """
	pull: int
	""" Push strength toward the hole, in ten thousandths of a block per tick. """
	phantoms: int
	""" Phantoms that only attack. """
	thieves: int
	""" Phantoms that also steal fragments. """


class Arena:
	""" Selectors of the arena whose id is in #pr_orbit_arena, shared by every generator of the trial. """
	def __init__(self) -> None:
		tag: str = f"{Mem.ctx.project_id}.{MODE}"
		self.same: str = write_match_predicate(f"{LAB}/orbit/same_arena", {f"{tag}.arena": f"#{MODE}_arena"})
		self.hole: str = self.marker("hole")
		self.collector: str = self.marker("collector")
		self.players: str = f"@a[tag={tag},{self.same}]"
		self.fragments: str = f"@e[type=minecraft:interaction,tag={tag}.fragment,{self.same}]"
		self.phantoms: str = f"@e[type=minecraft:phantom,tag={tag}.phantom,{self.same}]"

	def marker(self, name: str) -> str:
		""" Selector of one marker of the arena. """
		return f"@e[type=minecraft:marker,tag={Mem.ctx.project_id}.{MODE}.{name},{self.same},limit=1]"


# Constants (tables)
RINGS: list[Ring] = [
	Ring(radius=6,  height=1, speed=3),
	Ring(radius=10, height=0, speed=2, vertical_yaw=0),
	Ring(radius=14, height=0, speed=1, vertical_yaw=90),
]
""" The rings the fragments are spread over, one fragment out of three on each. """

ROUNDS: list[Round] = [
	Round(fragments=6,  pull=500, phantoms=0, thieves=0),
	Round(fragments=8,  pull=700, phantoms=3, thieves=0),
	Round(fragments=10, pull=900, phantoms=3, thieves=2),
]
""" The three rounds, in play order: about two minutes each for three players. """


# Functions
def main() -> None:
	""" Write every function of the orbit trial. """
	arena: Arena = Arena()
	generate_setup(arena)
	generate_arena_state(arena)
	generate_start(arena)
	generate_rounds(arena)
	generate_tick(arena)
	generate_phantoms(arena)
	generate_stop(arena)


def generate_setup(arena: Arena) -> None:
	""" Write the placement functions, each one run once from where the thing stands. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"
	objectives: str = "\n".join(f"scoreboard objectives add {tag}.{name} dummy" for name in ("carried", *STATE))

	write_function(f"{root}/here/place_black_hole", f"""
# A huge inverted cube rendered by the black hole shader, seen from inside
kill @e[type=minecraft:item_display,tag={tag}.sky,distance=..8]
$summon minecraft:item_display ~ ~ ~ {{Tags:["{tag}.sky"],item:{{id:"minecraft:stone",count:1,components:{{"minecraft:item_model":"{ns}:black_hole"}}}},view_range:10f,transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[-$(scale)f,-$(scale)f,-$(scale)f]}}}}

# Its marker anchors the arena of the room and pushes along the yaw of the caller, a hole placed again near the previous one keeps its arena
{objectives}
scoreboard players set #{MODE}_arena {ns}.data 0
execute as @n[type=minecraft:marker,tag={tag}.hole,distance=..{HOLE_RADIUS}] run scoreboard players operation #{MODE}_arena {ns}.data = @s {tag}.arena
kill @n[type=minecraft:marker,tag={tag}.hole,distance=..{HOLE_RADIUS}]
execute if score #{MODE}_arena {ns}.data matches 0 store result score #{MODE}_arena {ns}.data run scoreboard players add #{MODE}_arena_counter {ns}.data 1
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function {root}/new_hole
tellraw @a[distance=..16] {{"text":"Orbite : trou noir placé (arrivée des joueurs, poussée vers son yaw), place ensuite le collector.","color":"green"}}
""")

	write_function(f"{root}/new_hole", f"""
tag @s add {tag}.hole
rotate @s ~ 0
scoreboard players set #{MODE}_state {ns}.data 0
{copy_state(MODE, STATE, to_anchor=True)}
""")

	write_function(f"{root}/here/set_collector", f"""
# Joins the arena of the nearest hole, which must be placed first, with a glowing star and a label showing it from afar
execute unless entity @e[type=minecraft:marker,tag={tag}.hole] run return run tellraw @a[distance=..16] {{"text":"Orbite : place d'abord le trou noir (here/place_black_hole).","color":"red"}}
scoreboard players operation #{MODE}_arena {ns}.data = @n[type=minecraft:marker,tag={tag}.hole] {tag}.arena
kill @e[tag={tag}.collector,{arena.same}]
execute align xyz positioned ~0.5 ~ ~0.5 run function {root}/place_collector
tellraw @a[distance=..16] {{"text":"Orbite : collector placé (où les fragments sont déposés).","color":"green"}}
""")

	write_function(f"{root}/place_collector", f"""
summon minecraft:marker ~ ~ ~ {{Tags:["{tag}.collector","{tag}.new"]}}
summon minecraft:item_display ~ ~1.5 ~ {{Tags:["{tag}.collector","{tag}.new"],item:{{id:"minecraft:nether_star",count:1}},billboard:"center",glow_color_override:5636095,brightness:{{sky:15,block:15}},transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.5f,1.5f,1.5f]}}}}
summon minecraft:text_display ~ ~2.6 ~ {{Tags:["{tag}.collector","{tag}.new"],text:{crt_text("Dépôt des fragments")},billboard:"center",background:0,brightness:{{sky:15,block:15}}}}
scoreboard players operation @e[tag={tag}.new] {tag}.arena = #{MODE}_arena {ns}.data
tag @e[tag={tag}.new] remove {tag}.new
""")

	pick_block: str = "\n".join(f"execute if score #{MODE}_rock {ns}.data matches {index} run return run setblock ~ ~ ~ {block}" for index, block in enumerate(ROCK_BLOCKS))
	write_function(f"{root}/rock_block", f"""
execute store result score #{MODE}_rock {ns}.data run random value 0..{len(ROCK_BLOCKS) - 1}
{pick_block}
""")

	for size, radius in ROCK_RADII.items():
		cells: list[tuple[int, int, int, float]] = [
			(x, y, z, math.hypot(x, y, z))
			for x in range(-radius, radius + 1) for y in range(-radius, radius + 1) for z in range(-radius, radius + 1)
			if math.hypot(x, y, z) <= radius + 0.5
		]
		write_function(f"{root}/here/rock/{size}", "# A ball of dark stones centered here, whose outer layer is drawn at random so no two rocks are alike\n" + "\n".join(
			f"execute {'' if distance <= radius - 0.5 else f'if predicate {ns}:chance/0.5 '}positioned ~{x} ~{y} ~{z} run function {root}/rock_block"
			for x, y, z, distance in cells
		))


def generate_arena_state(arena: Arena) -> None:
	""" Write the state copies between a hole and the fake players, and the tick running every arena. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/load_arena", f"""
# @s is a hole
{copy_state(MODE, STATE, to_anchor=False)}
""")

	write_function(f"{root}/save_arena", f"""
# @s is a hole
{copy_state(MODE, STATE, to_anchor=True)}
""")

	write_function(f"{root}/tick", f"""
scoreboard players set #{MODE}_active {ns}.data 0
execute as @e[type=minecraft:marker,tag={tag}.hole] at @s run function {root}/arena_tick
execute if score #{MODE}_active {ns}.data matches 1.. run schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/arena_tick", f"""
# State: 1 round in play, 2 break between two rounds, 0 stopped
execute unless score @s {tag}.state matches 1..2 run return 0
function {root}/load_arena
scoreboard players add #{MODE}_clock {ns}.data 1
function {root}/push_tick
execute if score #{MODE}_state {ns}.data matches 1 run function {root}/play_tick
execute if score #{MODE}_state {ns}.data matches 2 run function {root}/break_tick
execute if score #{MODE}_state {ns}.data matches 1..2 run scoreboard players add #{MODE}_active {ns}.data 1
function {root}/save_arena
""")


def generate_start(arena: Arena) -> None:
	""" Write the start, taking every player stepping on a start pad and turning it into a light astronaut. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"
	free_player: str = f"tag=!{tag},distance=..{START_RADIUS},{ON_START_PAD},gamemode=!creative,gamemode=!spectator"
	markers_missing: str = "\n".join(
		f'execute unless entity {arena.marker(name)} run return run title @a[{free_player}] actionbar {{"text":"Orbite : pas de {name} pour ce trou noir, le poser avec here/set_{name}.","color":"red"}}'
		for name in MARKERS
	)
	take_pad: str = "\n".join(f"execute positioned {offset} if block ~ ~ ~ #{ns}:pr_stoupy/start_pad run return run function {root}/take_pad" for offset in PAD_OFFSETS)

	write_function(f"{root}/start", f"""
# Safe to fire every tick: a player on a start pad joins the room of the nearest hole, the first one starts round 1
execute unless entity @a[{free_player}] run return 0
execute unless entity @e[type=minecraft:marker,tag={tag}.hole] run return run title @a[{free_player}] actionbar {{"text":"Orbite : pas de trou noir, le poser avec here/place_black_hole.","color":"red"}}
execute as @n[type=minecraft:marker,tag={tag}.hole] run function {root}/load_arena
{markers_missing}

execute as @a[{free_player}] at @s run function {root}/enroll_player
execute if score #{MODE}_state {ns}.data matches 0 run function {root}/begin
execute as {arena.hole} run function {root}/save_arena
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/begin", f"""
scoreboard players set #{MODE}_round {ns}.data 0
scoreboard players set #{MODE}_clock {ns}.data 0
function {root}/next_round
""")

	write_function(f"{root}/enroll_player", f"""
tag @s add {tag}
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
scoreboard players set @s {tag}.carried 0
attribute @s minecraft:gravity base set {PLAYER_GRAVITY}
attribute @s minecraft:fall_damage_multiplier base set 0
# Phantoms still shove the player toward the hole, but a death would leave it tagged and pushed wherever it respawns
effect give @s minecraft:resistance infinite 4 true
give @s minecraft:iron_sword[custom_data={{{ns}:{{orbit_sword:true}}}},item_name={{"text":"Épée stellaire","color":"aqua"}}]
function {root}/find_pad
execute at {arena.hole} run tp @s ~ ~1 ~
""")

	write_function(f"{root}/find_pad", take_pad)

	write_function(f"{root}/take_pad", f"""
# The pad under the player is emptied until the game ends, a marker remembers where to put it back
setblock ~ ~ ~ minecraft:air
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function {root}/new_pad
""")

	write_function(f"{root}/new_pad", f"""
tag @s add {tag}.pad
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
""")


def generate_rounds(arena: Arena) -> None:
	""" Write the round starts, with their fragments laid on the rings and their phantoms, and the round checks. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"
	starts: str = "\n".join(f"execute if score #{MODE}_round {ns}.data matches {index} run function {root}/round/{index}" for index in range(1, len(ROUNDS) + 1))

	write_function(f"{root}/next_round", f"""
scoreboard players add #{MODE}_round {ns}.data 1
execute if score #{MODE}_round {ns}.data matches {len(ROUNDS) + 1}.. run return run function {root}/victory
scoreboard players set #{MODE}_state {ns}.data 1
scoreboard players set #{MODE}_banked {ns}.data 0
{starts}
""")

	for index, round_ in enumerate(ROUNDS, start=1):
		fragments: str = "\n".join(
			f"execute at {arena.hole} summon minecraft:interaction run function {root}/new_fragment {{ring:{fragment % len(RINGS)},{RINGS[fragment % len(RINGS)].rotation(fragment * 360 // round_.fragments)}}}"
			for fragment in range(round_.fragments)
		)
		phantoms: str = "\n".join(
			f"execute at {arena.hole} positioned ~ ~8 ~ summon minecraft:phantom run function {root}/{'new_thief' if phantom >= round_.phantoms else 'new_phantom'}"
			for phantom in range(round_.phantoms + round_.thieves)
		)
		write_function(f"{root}/round/{index}", f"""
scoreboard players set #{MODE}_required {ns}.data {round_.fragments}
scoreboard players set #{MODE}_pull {ns}.data {round_.pull}
{fragments}
{phantoms}
title {arena.players} times 10 50 10
title {arena.players} subtitle {crt_text(f"{round_.fragments} fragments à ramener" + (f", {round_.phantoms + round_.thieves} phantoms à abattre" if round_.phantoms + round_.thieves else ""))}
title {arena.players} title {crt_text(f"Round {index}/{len(ROUNDS)}")}
execute as {arena.players} at @s run playsound minecraft:block.beacon.power_select ambient @s
""")

	write_function(f"{root}/new_fragment", f"""
# @s is the hitbox the players touch or click, the star riding it is lowered into its middle
tag @s add {tag}.fragment
$tag @s add {tag}.ring$(ring)
$tag @s add {tag}.half$(half)
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
data merge entity @s {{width:1f,height:1f,response:1b}}
$rotate @s $(yaw) $(pitch)
tag @s add {tag}.new
execute summon minecraft:item_display run function {root}/new_star
tag @s remove {tag}.new
""")

	write_function(f"{root}/new_star", f"""
tag @s add {tag}.fragment
data merge entity @s {{item:{{id:"minecraft:nether_star",count:1}},billboard:"vertical",Glowing:1b,glow_color_override:5636095,brightness:{{sky:15,block:15}},transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,-0.5f,0f],scale:[0.8f,0.8f,0.8f]}}}}
ride @s mount @e[type=minecraft:interaction,tag={tag}.new,limit=1]
""")

	write_function(f"{root}/check_round", f"""
# Won once every fragment is banked and every phantom is dead
execute if score #{MODE}_banked {ns}.data < #{MODE}_required {ns}.data run return 0
execute if entity {arena.phantoms} run return 0
scoreboard players set #{MODE}_state {ns}.data 2
scoreboard players set #{MODE}_timer {ns}.data {BREAK_TICKS}
title {arena.players} times 10 40 10
title {arena.players} subtitle {crt_text("Préparez-vous au suivant")}
title {arena.players} title {crt_text("Round terminé !")}
execute as {arena.players} at @s run playsound minecraft:entity.player.levelup ambient @s
""")


def generate_tick(arena: Arena) -> None:
	""" Write the tick of one arena: the push of the hole, fragments turning, pickups, banking, and the swallowed players. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"
	turns: str = "\n".join(
		f"execute as @e[type=minecraft:interaction,tag={tag}.ring{index},tag=!{tag}.stolen,{arena.same}] at {arena.hole} run function {root}/turn/{index}"
		for index in range(len(RINGS))
	)

	write_function(f"{root}/push_tick", f"""
# The hole pushes during the rounds and the breaks between them alike
scoreboard players operation #{MODE}_step {ns}.data = #{MODE}_clock {ns}.data
scoreboard players operation #{MODE}_step {ns}.data %= #{PULL_PERIOD} {ns}.data
execute unless score #{MODE}_step {ns}.data matches 0 run return 0
execute as {arena.players} at @s run function {root}/pull
execute as {arena.players} run title @s actionbar {actionbar_text()}
""")

	write_function(f"{root}/break_tick", f"""
scoreboard players remove #{MODE}_timer {ns}.data 1
execute if score #{MODE}_timer {ns}.data matches ..0 run function {root}/next_round
""")

	write_function(f"{root}/play_tick", f"""
# Run as and at the hole of the arena, whose state is loaded in the fake players
{turns}
execute as @e[type=minecraft:interaction,tag={tag}.fragment,tag=!{tag}.stolen,{arena.same}] at @s as @p[tag={tag},{arena.same},distance=..{PICKUP_RADIUS}] run function {root}/pick_up
execute at {arena.collector} as @a[tag={tag},{arena.same},scores={{{tag}.carried=1..}},distance=..{BANK_RADIUS}] run function {root}/bank
function {root}/phantoms_tick
function {root}/check_round
""")

	for index, ring in enumerate(RINGS):
		write_function(f"{root}/turn/{index}", f"""
execute rotated as @s run rotate @s ~{ring.speed} ~
execute rotated as @s positioned ^ ^{ring.height} ^{ring.radius} run tp @s ~ ~ ~
""" if ring.vertical_yaw is None else f"""
# The pitch is clamped to 90 degrees, so each half of the circle is swept by pitch and the fragment turns over between them
execute if entity @s[tag=!{tag}.half1] run rotate @s ~ ~{ring.speed}
execute if entity @s[tag={tag}.half1] run rotate @s ~ ~-{ring.speed}
execute if entity @s[tag=!{tag}.half1,x_rotation=90] run function {root}/turn_over
execute if entity @s[tag={tag}.half1,x_rotation=-90] run function {root}/turn_over
execute rotated as @s positioned ~ ~{ring.height} ~ positioned ^ ^ ^{ring.radius} run tp @s ~ ~ ~
""")

	write_function(f"{root}/turn_over", f"""
rotate @s ~180 ~
execute if entity @s[tag={tag}.half1] run return run tag @s remove {tag}.half1
tag @s add {tag}.half1
""")

	write_function(f"{root}/pick_up", f"""
# @s is the player touching the fragment, which disappears from the orbit
scoreboard players add @s {tag}.carried 1
execute as @e[type=minecraft:interaction,tag={tag}.fragment,tag=!{tag}.stolen,{arena.same},distance=..{PICKUP_RADIUS},limit=1,sort=nearest] run function {root}/remove_fragment
playsound minecraft:entity.experience_orb.pickup ambient @s ~ ~ ~ 1 1.2
""")

	write_function(f"{root}/remove_fragment", """
execute on passengers run kill @s
kill @s
""")

	for trigger, name in (("minecraft:player_hurt_entity", "hit"), ("minecraft:player_interacted_with_entity", "use")):
		json_content: JsonDict = {
			"criteria": {"requirement": {"trigger": trigger, "conditions": {"entity": [
				{"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"entity_type": "minecraft:interaction", "entity_tags": {"all_of": [f"{tag}.fragment"]}}},
			]}}},
			"rewards": {"function": f"{root}/click"},
		}
		Mem.ctx.data[ns].advancements[f"{LAB}/orbit_{name}_fragment"] = set_json_encoder(Advancement(json_content), max_level=-1)

	write_function(f"{root}/click", f"""
# @s clicked a fragment, even one a thief is carrying away: it catches it like by touching it
advancement revoke @s only {ns}:{LAB}/orbit_hit_fragment
advancement revoke @s only {ns}:{LAB}/orbit_use_fragment
tag @s add {tag}.clicker
execute if entity @s[tag={tag}] as @e[type=minecraft:interaction,tag={tag}.fragment,distance=..8] if function {root}/clicked run function {root}/grab
tag @s remove {tag}.clicker
""")

	write_function(f"{root}/clicked", f"""
execute on attacker if entity @s[tag={tag}.clicker] run return 1
execute on target if entity @s[tag={tag}.clicker] run return 1
return 0
""")

	write_function(f"{root}/grab", f"""
scoreboard players add @a[tag={tag}.clicker,limit=1] {tag}.carried 1
execute as @a[tag={tag}.clicker,limit=1] at @s run playsound minecraft:entity.experience_orb.pickup ambient @s ~ ~ ~ 1 1.2
particle minecraft:end_rod ~ ~0.5 ~ 0.2 0.2 0.2 0.05 12
function {root}/remove_fragment
""")

	write_function(f"{root}/bank", f"""
scoreboard players operation #{MODE}_banked {ns}.data += @s {tag}.carried
scoreboard players set @s {tag}.carried 0
playsound minecraft:block.beacon.power_select ambient {arena.players} ~ ~ ~ 1 1.6
particle minecraft:end_rod ~ ~1 ~ 0.4 0.8 0.4 0.05 40
""")

	restore: str = "\n".join(
		f"execute if score @s {tag}.carried matches {count}.. at {arena.hole} summon minecraft:interaction run function {root}/new_fragment {{ring:{(count - 1) % len(RINGS)},{RINGS[(count - 1) % len(RINGS)].rotation(count * 97 % 360)}}}"
		for count in range(1, max(round_.fragments for round_ in ROUNDS) + 1)
	)
	write_function(f"{root}/swallow", f"""
# Called on a player who fell into the black hole, from any command block
execute unless entity @s[tag={tag}] run return fail
scoreboard players operation #{MODE}_arena {ns}.data = @s {tag}.arena
function {root}/swallowed
""")

	write_function(f"{root}/swallowed", f"""
# Back above the hole marker, and every fragment carried goes back to orbit
{restore}
scoreboard players set @s {tag}.carried 0
execute at {arena.hole} run tp @s ~ ~1 ~
effect give @s minecraft:blindness 2 0 true
playsound minecraft:entity.enderman.teleport ambient @s ~ ~ ~ 1 0.5
tellraw {arena.players} [{{"selector":"@s","color":"aqua"}},{{"text":" a été avalé par le trou noir !","color":"#01FE41"}}]
""")

	write_function(f"{root}/pull", f"""
# @s is a player, launched along the facing of the hole marker
scoreboard players operation $strength player_motion.api.launch = #{MODE}_pull {ns}.data
execute rotated as {arena.hole} run function player_motion:api/launch_looking
""")


def actionbar_text() -> str:
	""" Actionbar of a player: fragments carried and fragments banked by the team. """
	ns: str = Mem.ctx.project_id
	crt: str = "#01FE41"
	return (
		f'[{{"text":"Portés : ","color":"{crt}"}},{{"score":{{"name":"@s","objective":"{ns}.{MODE}.carried"}},"color":"{crt}"}},'
		f'{{"text":"   Déposés : ","color":"{crt}"}},{{"score":{{"name":"#{MODE}_banked","objective":"{ns}.data"}},"color":"{crt}"}},'
		f'{{"text":"/","color":"{crt}"}},{{"score":{{"name":"#{MODE}_required","objective":"{ns}.data"}},"color":"{crt}"}}]'
	)


def generate_phantoms(arena: Arena) -> None:
	""" Write the phantoms: every hit shoves the player toward the hole, and thieves dive into it with a fragment. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/new_phantom", f"""
tag @s add {tag}.phantom
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
data merge entity @s {{PersistenceRequired:1b,size:2,active_effects:[{{id:"minecraft:fire_resistance",duration:-1,amplifier:0b,show_particles:0b}}]}}
""")

	write_function(f"{root}/new_thief", f"""
function {root}/new_phantom
tag @s add {tag}.thief
data merge entity @s {{Glowing:1b,CustomName:{{"text":"Voleur d'étoiles","color":"red"}}}}
""")

	write_function(f"{root}/phantoms_tick", f"""
# A thief without loot tries to steal every {THIEF_PERIOD} ticks, a thief with loot dives toward the hole
scoreboard players operation #{MODE}_step {ns}.data = #{MODE}_clock {ns}.data
scoreboard players operation #{MODE}_step {ns}.data %= #{THIEF_PERIOD} {ns}.data
execute if score #{MODE}_step {ns}.data matches 0 as @e[type=minecraft:phantom,tag={tag}.thief,tag=!{tag}.diving,{arena.same},limit=1,sort=random] run function {root}/steal
execute as @e[type=minecraft:phantom,tag={tag}.diving,{arena.same}] at @s rotated as {arena.hole} run function {root}/dive

# The fragment of a thief killed on the way falls back into orbit
execute as @e[type=minecraft:interaction,tag={tag}.stolen,{arena.same}] unless predicate {ns}:riding run tag @s remove {tag}.stolen
""")

	write_function(f"{root}/steal", f"""
execute unless entity @e[type=minecraft:interaction,tag={tag}.fragment,tag=!{tag}.stolen,{arena.same}] run return fail
tag @s add {tag}.diving
data merge entity @s {{NoAI:1b}}
tag @e[type=minecraft:interaction,tag={tag}.fragment,tag=!{tag}.stolen,{arena.same},limit=1,sort=random] add {tag}.stealing
ride @e[type=minecraft:interaction,tag={tag}.stealing,limit=1] mount @s
tag @e[type=minecraft:interaction,tag={tag}.stealing] add {tag}.stolen
tag @e[type=minecraft:interaction,tag={tag}.stealing] remove {tag}.stealing
execute at @s run playsound minecraft:entity.phantom.swoop hostile {arena.players} ~ ~ ~ 2 0.6
tellraw {arena.players} {{"text":"Un voleur d'étoiles emporte un fragment vers le trou noir !","color":"red"}}
""")

	write_function(f"{root}/dive", f"""
# Along the push of the hole until the wall it is painted on
tp @s ^ ^ ^{THIEF_SPEED} ~ ~
execute positioned ^ ^ ^1 unless block ~ ~ ~ #minecraft:air run function {root}/thief_swallowed
""")

	write_function(f"{root}/thief_swallowed", f"""
# The stolen fragment goes back to its ring, and the thief is gone for good
execute on passengers run tag @s remove {tag}.stolen
execute on passengers run ride @s dismount
tp @s ~ -1000 ~
kill @s
""")

	json_content: JsonDict = {
		"criteria": {"requirement": {"trigger": "minecraft:entity_hurt_player", "conditions": {
			"player": [{"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"entity_tags": {"all_of": [tag]}}}],
			"damage": {"source_entity": {"entity_type": "minecraft:phantom"}},
		}}},
		"rewards": {"function": f"{root}/phantom_hit"},
	}
	Mem.ctx.data[ns].advancements[f"{LAB}/orbit_phantom_hit"] = set_json_encoder(Advancement(json_content), max_level=-1)

	write_function(f"{root}/phantom_hit", f"""
advancement revoke @s only {ns}:{LAB}/orbit_phantom_hit
scoreboard players operation #{MODE}_arena {ns}.data = @s {tag}.arena
scoreboard players set $strength player_motion.api.launch {PHANTOM_PUSH}
execute at @s rotated as {arena.hole} run function player_motion:api/launch_looking
""")


def generate_stop(arena: Arena) -> None:
	""" Write the victory and the stops, of the nearest room or of all of them. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/victory", f"""
execute as @r[tag={tag},{arena.same}] at @s run function {ns}:{LAB}/give_star {{trial:"L'orbite"}}
function {root}/stop_arena
""")

	write_function(f"{root}/stop_arena", f"""
# The arena loaded in the fake players goes back to rest
execute as {arena.fragments} run function {root}/remove_fragment
execute as {arena.phantoms} run tp @s ~ -1000 ~
kill {arena.phantoms}
execute as {arena.players} run attribute @s minecraft:gravity base reset
execute as {arena.players} run attribute @s minecraft:fall_damage_multiplier base reset
effect clear {arena.players} minecraft:resistance
clear {arena.players} *[custom_data~{{{ns}:{{orbit_sword:true}}}}]
tag {arena.players} remove {tag}
execute at @e[type=minecraft:marker,tag={tag}.pad,{arena.same}] run setblock ~ ~ ~ {START_PAD_BLOCKS[0]}
kill @e[type=minecraft:marker,tag={tag}.pad,{arena.same}]
scoreboard players set #{MODE}_state {ns}.data 0
""")

	write_function(f"{root}/stop_hole", f"""
function {root}/load_arena
function {root}/stop_arena
function {root}/save_arena
""")

	write_function(f"{root}/here/stop", f"""
# The room of the nearest hole only
execute as @n[type=minecraft:marker,tag={tag}.hole] run function {root}/stop_hole
""")

	write_function(f"{root}/stop", f"""
# Every room, everywhere
execute as @e[type=minecraft:marker,tag={tag}.hole] run function {root}/stop_hole
schedule clear {root}/tick
""")

