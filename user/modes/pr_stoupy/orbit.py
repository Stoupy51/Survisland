""" Trial "Orbite": two to four players in a room pulled toward a black hole, over three rounds.

Star fragments circle around the orbit center on three rings. A player picks one up by touching it
and banks it at the collector, on the far side of the room, against the pull of the hole.
Getting too close to the hole sends the player back to the spawn and returns the fragments it carried to orbit.
From the second round phantoms join, and in the third some of them steal fragments and dive into the hole with them.
A round is won once all its fragments are banked and all its phantoms are dead.

Each room is an arena anchored on its hole marker, which holds the state of the game in its own scores.
The other markers, the players, the fragments and the phantoms carry the arena id, so several copies of the room run side by side.
"""
# ruff: noqa: E501
# Imports
from dataclasses import dataclass

from stewbeet import Advancement, JsonDict, Mem, set_json_encoder, write_function

from .shared import LAB, copy_state, crt_text, write_match_predicate

# Constants
MODE: str = "pr_orbit"
""" Suffix of the tags, objectives and fake players of the trial. """

MIN_PLAYERS: int = 2
""" Players needed around the start command block. """

MAX_PLAYERS: int = 4
""" Players taken at most, the nearest ones. """

START_RADIUS: int = 6
""" Radius around the start command block where the players are taken. """

HOLE_RADIUS: int = 16
""" Radius around a new hole marker in which the previous hole of the same room is replaced, keeping its arena. """

SWALLOW_RADIUS: int = 3
""" Distance to the hole under which a player is swallowed. """

INNER_RADIUS: int = 12
""" Distance to the hole under which the pull gets stronger. """

PICKUP_RADIUS: str = "1.6"
""" Distance at which a player picks up a fragment. """

BANK_RADIUS: int = 3
""" Distance to the collector at which carried fragments are banked. """

PULL_PERIOD: int = 4
""" Ticks between two pulls, each one being a player_motion launch toward the hole. """

PLAYER_GRAVITY: str = "0.05"
""" Gravity of the players during the trial, vanilla being 0.08. """

PHANTOM_PUSH: int = 6000
""" Strength of the shove toward the hole given by a phantom hit, in ten thousandths of a block per tick. """

THIEF_PERIOD: int = 200
""" Ticks between two thefts attempts of a thief phantom. """

THIEF_SPEED: str = "0.18"
""" Blocks per tick of a thief diving into the hole. """

BREAK_TICKS: int = 100
""" Ticks of rest between two rounds. """

STATE: tuple[str, ...] = ("arena", "state", "round", "banked", "required", "pull", "inner_pull", "timer", "clock")
""" Scores of the hole marker holding the state of its arena, each one mirrored by a #pr_orbit_<name> fake player. """

MARKERS: dict[str, str] = {
	"orbit": "centre des anneaux de fragments",
	"collector": "où les fragments sont déposés",
	"spawn": "départ et retour des joueurs avalés",
}
""" Markers of a room besides its hole, each one joining the arena of the nearest hole when placed. """


# Classes
@dataclass(frozen=True)
class Ring:
	""" One orbit of the fragments around the orbit center. """
	radius: int
	""" Horizontal distance to the center, in blocks. """
	height: int
	""" Height above the center, in blocks. """
	speed: int
	""" Degrees turned per tick, negative for the other way round. """


@dataclass(frozen=True)
class Round:
	""" Content and difficulty of one round. """
	fragments: int
	""" Fragments to bank, spread over the rings. """
	pull: int
	""" Pull strength far from the hole, in ten thousandths of a block per tick. """
	inner_pull: int
	""" Pull strength within INNER_RADIUS of the hole. """
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
		self.orbit: str = self.marker("orbit")
		self.collector: str = self.marker("collector")
		self.spawn: str = self.marker("spawn")
		self.players: str = f"@a[tag={tag},{self.same}]"
		self.fragments: str = f"@e[type=minecraft:item_display,tag={tag}.fragment,{self.same}]"
		self.phantoms: str = f"@e[type=minecraft:phantom,tag={tag}.phantom,{self.same}]"

	def marker(self, name: str) -> str:
		""" Selector of one marker of the arena. """
		return f"@e[type=minecraft:marker,tag={Mem.ctx.project_id}.{MODE}.{name},{self.same},limit=1]"


# Constants (tables)
RINGS: list[Ring] = [
	Ring(radius=6,  height=1, speed=3),
	Ring(radius=10, height=3, speed=-2),
	Ring(radius=14, height=0, speed=1),
]
""" The rings the fragments are spread over, one fragment out of three on each. """

ROUNDS: list[Round] = [
	Round(fragments=6,  pull=1000, inner_pull=1600, phantoms=0, thieves=0),
	Round(fragments=8,  pull=1400, inner_pull=2200, phantoms=3, thieves=0),
	Round(fragments=10, pull=1800, inner_pull=2800, phantoms=3, thieves=2),
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

	write_function(f"{root}/here/set_hole", f"""
# The hole anchors the arena of the room, a hole placed again near the previous one keeps its arena
{objectives}
scoreboard players set #{MODE}_arena {ns}.data 0
execute as @n[type=minecraft:marker,tag={tag}.hole,distance=..{HOLE_RADIUS}] run scoreboard players operation #{MODE}_arena {ns}.data = @s {tag}.arena
kill @n[type=minecraft:marker,tag={tag}.hole,distance=..{HOLE_RADIUS}]
execute if score #{MODE}_arena {ns}.data matches 0 store result score #{MODE}_arena {ns}.data run scoreboard players add #{MODE}_arena_counter {ns}.data 1
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function {root}/new_hole
tellraw @a[distance=..16] {{"text":"Orbite : trou noir placé (cible de l'attraction), place ensuite orbit, collector et spawn.","color":"green"}}
""")

	write_function(f"{root}/new_hole", f"""
tag @s add {tag}.hole
scoreboard players set #{MODE}_state {ns}.data 0
{copy_state(MODE, STATE, to_anchor=True)}
""")

	for name, role in MARKERS.items():
		write_function(f"{root}/here/set_{name}", f"""
# Joins the arena of the nearest hole, which must be placed first
execute unless entity @e[type=minecraft:marker,tag={tag}.hole] run return run tellraw @a[distance=..16] {{"text":"Orbite : place d'abord le trou noir (here/set_hole).","color":"red"}}
scoreboard players operation #{MODE}_arena {ns}.data = @n[type=minecraft:marker,tag={tag}.hole] {tag}.arena
kill @e[type=minecraft:marker,tag={tag}.{name},{arena.same}]
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function {root}/new_marker {{name:"{name}"}}
tellraw @a[distance=..16] {{"text":"Orbite : {name} placé ({role}).","color":"green"}}
""")

	write_function(f"{root}/new_marker", f"""
$tag @s add {tag}.$(name)
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
""")

	write_function(f"{root}/here/place_black_hole", f"""
# A huge inverted cube rendered by the black hole shader, seen from inside
kill @e[type=minecraft:item_display,tag={tag}.sky,distance=..8]
$summon minecraft:item_display ~ ~ ~ {{Tags:["{tag}.sky"],item:{{id:"minecraft:stone",count:1,components:{{"minecraft:item_model":"{ns}:black_hole"}}}},view_range:10f,transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[-$(scale)f,-$(scale)f,-$(scale)f]}}}}
""")


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
execute if score #{MODE}_state {ns}.data matches 1 run function {root}/play_tick
execute if score #{MODE}_state {ns}.data matches 2 run function {root}/break_tick
execute if score #{MODE}_state {ns}.data matches 1..2 run scoreboard players add #{MODE}_active {ns}.data 1
function {root}/save_arena
""")


def generate_start(arena: Arena) -> None:
	""" Write the start, taking the players around the command block and turning them into light astronauts. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"
	free_player: str = f"tag=!{tag},distance=..{START_RADIUS},gamemode=!creative,gamemode=!spectator"
	markers_missing: str = "\n".join(f"execute unless entity {arena.marker(name)} run return 0" for name in MARKERS)

	write_function(f"{root}/start", f"""
# Safe to fire every tick: the room of the nearest hole starts once idle, fully placed, with enough free players here
execute unless entity @e[type=minecraft:marker,tag={tag}.hole] run return 0
execute if score @n[type=minecraft:marker,tag={tag}.hole] {tag}.state matches 1.. run return 0
execute store result score #{MODE}_free {ns}.data if entity @a[{free_player}]
execute if score #{MODE}_free {ns}.data matches ..{MIN_PLAYERS - 1} run return 0
execute as @n[type=minecraft:marker,tag={tag}.hole] run function {root}/load_arena
{markers_missing}

execute as @a[{free_player},limit={MAX_PLAYERS},sort=nearest] run function {root}/enroll_player
scoreboard players set #{MODE}_round {ns}.data 0
scoreboard players set #{MODE}_clock {ns}.data 0
function {root}/next_round
execute as {arena.hole} run function {root}/save_arena
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/enroll_player", f"""
tag @s add {tag}
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
scoreboard players set @s {tag}.carried 0
attribute @s minecraft:gravity base set {PLAYER_GRAVITY}
attribute @s minecraft:fall_damage_multiplier base set 0
give @s minecraft:iron_sword[custom_data={{{ns}:{{orbit_sword:true}}}},item_name={{"text":"Épée stellaire","color":"aqua"}}]
tp @s {arena.spawn}
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
			f"execute at {arena.orbit} summon minecraft:item_display run function {root}/new_fragment {{ring:{fragment % len(RINGS)},angle:{fragment * 360 // round_.fragments}}}"
			for fragment in range(round_.fragments)
		)
		phantoms: str = "\n".join(
			f"execute at {arena.orbit} positioned ~ ~8 ~ summon minecraft:phantom run function {root}/{'new_thief' if phantom >= round_.phantoms else 'new_phantom'}"
			for phantom in range(round_.phantoms + round_.thieves)
		)
		write_function(f"{root}/round/{index}", f"""
scoreboard players set #{MODE}_required {ns}.data {round_.fragments}
scoreboard players set #{MODE}_pull {ns}.data {round_.pull}
scoreboard players set #{MODE}_inner_pull {ns}.data {round_.inner_pull}
{fragments}
{phantoms}
title {arena.players} times 10 50 10
title {arena.players} subtitle {crt_text(f"{round_.fragments} fragments à ramener" + (f", {round_.phantoms + round_.thieves} phantoms à abattre" if round_.phantoms + round_.thieves else ""))}
title {arena.players} title {crt_text(f"Round {index}/{len(ROUNDS)}")}
execute as {arena.players} at @s run playsound minecraft:block.beacon.power_select master @s
""")

	write_function(f"{root}/new_fragment", f"""
tag @s add {tag}.fragment
$tag @s add {tag}.ring$(ring)
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
data merge entity @s {{item:{{id:"minecraft:nether_star",count:1}},billboard:"fixed",Glowing:1b,glow_color_override:5636095,teleport_duration:1,brightness:{{sky:15,block:15}},transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}}}
$rotate @s $(angle) 0
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
execute as {arena.players} at @s run playsound minecraft:entity.player.levelup master @s
""")


def generate_tick(arena: Arena) -> None:
	""" Write the tick of one arena: fragments turning, pickups, banking, the pull of the hole and the swallowed players. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"
	turns: str = "\n".join(
		f"execute as @e[type=minecraft:item_display,tag={tag}.ring{index},tag=!{tag}.stolen,{arena.same}] at {arena.orbit} run function {root}/turn/{index}"
		for index in range(len(RINGS))
	)

	write_function(f"{root}/break_tick", f"""
scoreboard players remove #{MODE}_timer {ns}.data 1
execute if score #{MODE}_timer {ns}.data matches ..0 run function {root}/next_round
""")

	write_function(f"{root}/play_tick", f"""
# Run as and at the hole of the arena, whose state is loaded in the fake players
scoreboard players add #{MODE}_clock {ns}.data 1
{turns}
execute as @e[type=minecraft:item_display,tag={tag}.fragment,tag=!{tag}.stolen,{arena.same}] at @s as @p[tag={tag},{arena.same},distance=..{PICKUP_RADIUS}] run function {root}/pick_up
execute at {arena.collector} as @a[tag={tag},{arena.same},scores={{{tag}.carried=1..}},distance=..{BANK_RADIUS}] run function {root}/bank
execute as @a[tag={tag},{arena.same},distance=..{SWALLOW_RADIUS}] run function {root}/swallowed

scoreboard players operation #{MODE}_step {ns}.data = #{MODE}_clock {ns}.data
scoreboard players operation #{MODE}_step {ns}.data %= #{PULL_PERIOD} {ns}.data
execute if score #{MODE}_step {ns}.data matches 0 as {arena.players} at @s run function {root}/pull
execute if score #{MODE}_step {ns}.data matches 0 as {arena.players} run title @s actionbar {actionbar_text()}

function {root}/phantoms_tick
function {root}/check_round
""")

	for index, ring in enumerate(RINGS):
		write_function(f"{root}/turn/{index}", f"""
execute rotated as @s run rotate @s ~{ring.speed} ~
execute rotated as @s positioned ^ ^{ring.height} ^{ring.radius} run tp @s ~ ~ ~
""")

	write_function(f"{root}/pick_up", f"""
# @s is the player touching the fragment, which disappears from the orbit
scoreboard players add @s {tag}.carried 1
execute as @e[type=minecraft:item_display,tag={tag}.fragment,tag=!{tag}.stolen,{arena.same},distance=..{PICKUP_RADIUS},limit=1,sort=nearest] run kill @s
playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1.2
""")

	write_function(f"{root}/bank", f"""
scoreboard players operation #{MODE}_banked {ns}.data += @s {tag}.carried
scoreboard players set @s {tag}.carried 0
playsound minecraft:block.beacon.power_select master {arena.players} ~ ~ ~ 1 1.6
particle minecraft:end_rod ~ ~1 ~ 0.4 0.8 0.4 0.05 40
""")

	restore: str = "\n".join(
		f"execute if score @s {tag}.carried matches {count}.. at {arena.orbit} summon minecraft:item_display run function {root}/new_fragment {{ring:{(count - 1) % len(RINGS)},angle:{count * 97 % 360}}}"
		for count in range(1, max(round_.fragments for round_ in ROUNDS) + 1)
	)
	write_function(f"{root}/swallowed", f"""
# Back to the spawn, and every fragment carried goes back to orbit
{restore}
scoreboard players set @s {tag}.carried 0
tp @s {arena.spawn}
effect give @s minecraft:blindness 2 0 true
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 0.5
tellraw {arena.players} [{{"selector":"@s","color":"aqua"}},{{"text":" a été avalé par le trou noir !","color":"#01FE41"}}]
""")

	write_function(f"{root}/pull", f"""
# @s is a player, launched toward the hole, harder once within {INNER_RADIUS} blocks of it
scoreboard players operation $strength player_motion.api.launch = #{MODE}_pull {ns}.data
execute at {arena.hole} if entity @s[distance=..{INNER_RADIUS}] run scoreboard players operation $strength player_motion.api.launch = #{MODE}_inner_pull {ns}.data
execute facing entity {arena.hole} feet run function player_motion:api/launch_looking
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
execute as @e[type=minecraft:phantom,tag={tag}.diving,{arena.same}] at @s facing entity {arena.hole} feet run function {root}/dive

# The fragment of a thief killed on the way falls back into orbit
execute as @e[type=minecraft:item_display,tag={tag}.stolen,{arena.same}] unless predicate {ns}:riding run tag @s remove {tag}.stolen
""")

	write_function(f"{root}/steal", f"""
execute unless entity @e[type=minecraft:item_display,tag={tag}.fragment,tag=!{tag}.stolen,{arena.same}] run return fail
tag @s add {tag}.diving
data merge entity @s {{NoAI:1b}}
tag @e[type=minecraft:item_display,tag={tag}.fragment,tag=!{tag}.stolen,{arena.same},limit=1,sort=random] add {tag}.stealing
ride @e[type=minecraft:item_display,tag={tag}.stealing,limit=1] mount @s
tag @e[type=minecraft:item_display,tag={tag}.stealing] add {tag}.stolen
tag @e[type=minecraft:item_display,tag={tag}.stealing] remove {tag}.stealing
execute at @s run playsound minecraft:entity.phantom.swoop hostile {arena.players} ~ ~ ~ 2 0.6
tellraw {arena.players} {{"text":"Un voleur d'étoiles emporte un fragment vers le trou noir !","color":"red"}}
""")

	write_function(f"{root}/dive", f"""
tp @s ^ ^ ^{THIEF_SPEED} ~ ~
execute at {arena.hole} if entity @s[distance=..{SWALLOW_RADIUS}] run function {root}/thief_swallowed
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
execute at @s facing entity {arena.hole} feet run function player_motion:api/launch_looking
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
kill {arena.fragments}
execute as {arena.phantoms} run tp @s ~ -1000 ~
kill {arena.phantoms}
execute as {arena.players} run attribute @s minecraft:gravity base reset
execute as {arena.players} run attribute @s minecraft:fall_damage_multiplier base reset
clear {arena.players} *[custom_data~{{{ns}:{{orbit_sword:true}}}}]
tag {arena.players} remove {tag}
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

