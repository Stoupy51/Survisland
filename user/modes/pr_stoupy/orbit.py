""" Trial "Orbite": two to four players in a room pulled toward a black hole, over three rounds.

Star fragments circle around the orbit center on three rings. A player picks one up by touching it
and banks it at the collector, on the far side of the room, against the pull of the hole.
Getting too close to the hole sends the player back to the spawn and returns the fragments it carried to orbit.
From the second round phantoms join, and in the third some of them steal fragments and dive into the hole with them.
A round is won once all its fragments are banked and all its phantoms are dead.
"""
# ruff: noqa: E501
# Imports
from dataclasses import dataclass

from stewbeet import Advancement, JsonDict, Mem, set_json_encoder, write_function

from .shared import LAB, crt_text

# Constants
MODE: str = "pr_orbit"
""" Suffix of the tags, objectives and fake players of the trial. """

MIN_PLAYERS: int = 2
""" Players needed around the start command block. """

MAX_PLAYERS: int = 4
""" Players taken at most, the nearest ones. """

START_RADIUS: int = 6
""" Radius around the start command block where the players are taken. """

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
	generate_setup()
	generate_start()
	generate_rounds()
	generate_tick()
	generate_phantoms()
	generate_stop()


def generate_setup() -> None:
	""" Write the placement functions, each one run once from where the thing stands. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"

	for name, role in (("hole", "cible de l'attraction, là où le trou noir apparaît"), ("orbit", "centre des anneaux de fragments"), ("collector", "où les fragments sont déposés"), ("spawn", "départ et retour des joueurs avalés")):
		write_function(f"{root}/here/set_{name}", f"""
kill @e[type=minecraft:marker,tag={tag}.{name}]
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run tag @s add {tag}.{name}
tellraw @a[distance=..16] {{"text":"Orbite : {name} placé ({role}).","color":"green"}}
""")

	write_function(f"{root}/here/place_black_hole", f"""
# A huge inverted cube rendered by the black hole shader, seen from inside
kill @e[type=minecraft:item_display,tag={tag}.sky,distance=..8]
$summon minecraft:item_display ~ ~ ~ {{Tags:["{tag}.sky"],item:{{id:"minecraft:stone",count:1,components:{{"minecraft:item_model":"{ns}:black_hole"}}}},view_range:10f,transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[-$(scale)f,-$(scale)f,-$(scale)f]}}}}
""")


def generate_start() -> None:
	""" Write the start, taking the players around the command block and turning them into light astronauts. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"
	free_player: str = f"tag=!{tag},distance=..{START_RADIUS},gamemode=!creative,gamemode=!spectator"

	write_function(f"{root}/start", f"""
# Safe to fire every tick: one game at a time, once every marker is placed
execute if score #{MODE}_state {ns}.data matches 1.. run return 0
execute unless entity @e[type=minecraft:marker,tag={tag}.hole] run return 0
execute unless entity @e[type=minecraft:marker,tag={tag}.orbit] run return 0
execute unless entity @e[type=minecraft:marker,tag={tag}.collector] run return 0
execute unless entity @e[type=minecraft:marker,tag={tag}.spawn] run return 0
execute store result score #{MODE}_free {ns}.data if entity @a[{free_player}]
execute if score #{MODE}_free {ns}.data matches ..{MIN_PLAYERS - 1} run return 0

scoreboard objectives add {tag}.carried dummy
execute as @a[{free_player},limit={MAX_PLAYERS},sort=nearest] run function {root}/enroll_player

scoreboard players set #{MODE}_round {ns}.data 0
scoreboard players set #{MODE}_clock {ns}.data 0
function {root}/next_round
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/enroll_player", f"""
tag @s add {tag}
scoreboard players set @s {tag}.carried 0
attribute @s minecraft:gravity base set {PLAYER_GRAVITY}
attribute @s minecraft:fall_damage_multiplier base set 0
give @s minecraft:iron_sword[custom_data={{{ns}:{{orbit_sword:true}}}},item_name={{"text":"Épée stellaire","color":"aqua"}}]
tp @s @e[type=minecraft:marker,tag={tag}.spawn,limit=1]
""")


def generate_rounds() -> None:
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
			f"execute at @e[type=minecraft:marker,tag={tag}.orbit,limit=1] summon minecraft:item_display run function {root}/new_fragment {{ring:{fragment % len(RINGS)},angle:{fragment * 360 // round_.fragments}}}"
			for fragment in range(round_.fragments)
		)
		phantoms: str = "\n".join(
			f"execute at @e[type=minecraft:marker,tag={tag}.orbit,limit=1] positioned ~ ~8 ~ summon minecraft:phantom run function {root}/{'new_thief' if phantom >= round_.phantoms else 'new_phantom'}"
			for phantom in range(round_.phantoms + round_.thieves)
		)
		write_function(f"{root}/round/{index}", f"""
scoreboard players set #{MODE}_required {ns}.data {round_.fragments}
scoreboard players set #{MODE}_pull {ns}.data {round_.pull}
scoreboard players set #{MODE}_inner_pull {ns}.data {round_.inner_pull}
{fragments}
{phantoms}
title @a[tag={tag}] times 10 50 10
title @a[tag={tag}] subtitle {crt_text(f"{round_.fragments} fragments à ramener" + (f", {round_.phantoms + round_.thieves} phantoms à abattre" if round_.phantoms + round_.thieves else ""))}
title @a[tag={tag}] title {crt_text(f"Round {index}/{len(ROUNDS)}")}
execute as @a[tag={tag}] at @s run playsound minecraft:block.beacon.power_select master @s
""")

	write_function(f"{root}/new_fragment", f"""
tag @s add {tag}.fragment
$tag @s add {tag}.ring$(ring)
data merge entity @s {{item:{{id:"minecraft:nether_star",count:1}},billboard:"fixed",Glowing:1b,glow_color_override:5636095,teleport_duration:1,brightness:{{sky:15,block:15}},transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}}}
$rotate @s $(angle) 0
""")

	write_function(f"{root}/check_round", f"""
# Won once every fragment is banked and every phantom is dead
execute if score #{MODE}_banked {ns}.data < #{MODE}_required {ns}.data run return 0
execute if entity @e[type=minecraft:phantom,tag={tag}.phantom] run return 0
scoreboard players set #{MODE}_state {ns}.data 2
scoreboard players set #{MODE}_timer {ns}.data {BREAK_TICKS}
title @a[tag={tag}] times 10 40 10
title @a[tag={tag}] subtitle {crt_text("Préparez-vous au suivant")}
title @a[tag={tag}] title {crt_text("Round terminé !")}
execute as @a[tag={tag}] at @s run playsound minecraft:entity.player.levelup master @s
""")


def generate_tick() -> None:
	""" Write the tick: fragments turning, pickups, banking, the pull of the hole and the swallowed players. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"
	hole: str = f"@e[type=minecraft:marker,tag={tag}.hole,limit=1]"
	orbit: str = f"@e[type=minecraft:marker,tag={tag}.orbit,limit=1]"
	turns: str = "\n".join(
		f"execute as @e[type=minecraft:item_display,tag={tag}.ring{index},tag=!{tag}.stolen] at {orbit} run function {root}/turn/{index}"
		for index in range(len(RINGS))
	)

	write_function(f"{root}/tick", f"""
# State: 1 round in play, 2 break between two rounds, 0 stopped
execute if score #{MODE}_state {ns}.data matches 1 run function {root}/play_tick
execute if score #{MODE}_state {ns}.data matches 2 run function {root}/break_tick
execute if score #{MODE}_state {ns}.data matches 1..2 run schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/break_tick", f"""
scoreboard players remove #{MODE}_timer {ns}.data 1
execute if score #{MODE}_timer {ns}.data matches ..0 run function {root}/next_round
""")

	write_function(f"{root}/play_tick", f"""
scoreboard players add #{MODE}_clock {ns}.data 1
{turns}
execute as @e[type=minecraft:item_display,tag={tag}.fragment,tag=!{tag}.stolen] at @s as @p[tag={tag},distance=..{PICKUP_RADIUS}] run function {root}/pick_up
execute at @e[type=minecraft:marker,tag={tag}.collector,limit=1] as @a[tag={tag},scores={{{tag}.carried=1..}},distance=..{BANK_RADIUS}] run function {root}/bank
execute at {hole} as @a[tag={tag},distance=..{SWALLOW_RADIUS}] run function {root}/swallowed

scoreboard players operation #{MODE}_step {ns}.data = #{MODE}_clock {ns}.data
scoreboard players operation #{MODE}_step {ns}.data %= #{PULL_PERIOD} {ns}.data
execute if score #{MODE}_step {ns}.data matches 0 as @a[tag={tag}] at @s run function {root}/pull
execute if score #{MODE}_step {ns}.data matches 0 as @a[tag={tag}] run title @s actionbar {actionbar_text()}

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
execute as @e[type=minecraft:item_display,tag={tag}.fragment,tag=!{tag}.stolen,distance=..{PICKUP_RADIUS},limit=1,sort=nearest] run kill @s
playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1.2
""")

	write_function(f"{root}/bank", f"""
scoreboard players operation #{MODE}_banked {ns}.data += @s {tag}.carried
scoreboard players set @s {tag}.carried 0
playsound minecraft:block.beacon.power_select master @a[tag={tag}] ~ ~ ~ 1 1.6
particle minecraft:end_rod ~ ~1 ~ 0.4 0.8 0.4 0.05 40
""")

	restore: str = "\n".join(
		f"execute if score @s {tag}.carried matches {count}.. at {orbit} summon minecraft:item_display run function {root}/new_fragment {{ring:{(count - 1) % len(RINGS)},angle:{count * 97 % 360}}}"
		for count in range(1, max(round_.fragments for round_ in ROUNDS) + 1)
	)
	write_function(f"{root}/swallowed", f"""
# Back to the spawn, and every fragment carried goes back to orbit
{restore}
scoreboard players set @s {tag}.carried 0
tp @s @e[type=minecraft:marker,tag={tag}.spawn,limit=1]
effect give @s minecraft:blindness 2 0 true
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 0.5
tellraw @a[tag={tag}] [{{"selector":"@s","color":"aqua"}},{{"text":" a été avalé par le trou noir !","color":"#01FE41"}}]
""")

	write_function(f"{root}/pull", f"""
# @s is a player, launched toward the hole, harder once within {INNER_RADIUS} blocks of it
scoreboard players operation $strength player_motion.api.launch = #{MODE}_pull {ns}.data
execute at {hole} if entity @s[distance=..{INNER_RADIUS}] run scoreboard players operation $strength player_motion.api.launch = #{MODE}_inner_pull {ns}.data
execute facing entity {hole} feet run function player_motion:api/launch_looking
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


def generate_phantoms() -> None:
	""" Write the phantoms: every hit shoves the player toward the hole, and thieves dive into it with a fragment. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"
	hole: str = f"@e[type=minecraft:marker,tag={tag}.hole,limit=1]"

	write_function(f"{root}/new_phantom", f"""
tag @s add {tag}.phantom
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
execute if score #{MODE}_step {ns}.data matches 0 as @e[type=minecraft:phantom,tag={tag}.thief,tag=!{tag}.diving,limit=1,sort=random] run function {root}/steal
execute as @e[type=minecraft:phantom,tag={tag}.diving] at @s facing entity {hole} feet run function {root}/dive

# The fragment of a thief killed on the way falls back into orbit
execute as @e[type=minecraft:item_display,tag={tag}.stolen] unless predicate {ns}:riding run tag @s remove {tag}.stolen
""")

	write_function(f"{root}/steal", f"""
execute unless entity @e[type=minecraft:item_display,tag={tag}.fragment,tag=!{tag}.stolen] run return fail
tag @s add {tag}.diving
data merge entity @s {{NoAI:1b}}
tag @e[type=minecraft:item_display,tag={tag}.fragment,tag=!{tag}.stolen,limit=1,sort=random] add {tag}.stealing
ride @e[type=minecraft:item_display,tag={tag}.stealing,limit=1] mount @s
tag @e[type=minecraft:item_display,tag={tag}.stealing] add {tag}.stolen
tag @e[type=minecraft:item_display,tag={tag}.stealing] remove {tag}.stealing
execute at @s run playsound minecraft:entity.phantom.swoop hostile @a[tag={tag}] ~ ~ ~ 2 0.6
tellraw @a[tag={tag}] {{"text":"Un voleur d'étoiles emporte un fragment vers le trou noir !","color":"red"}}
""")

	write_function(f"{root}/dive", f"""
tp @s ^ ^ ^{THIEF_SPEED} ~ ~
execute at {hole} if entity @s[distance=..{SWALLOW_RADIUS}] run function {root}/thief_swallowed
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
			"player": [{"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"nbt": f'{{Tags:["{tag}"]}}'}}],
			"damage": {"source_entity": {"type": "minecraft:phantom"}},
		}}},
		"rewards": {"function": f"{root}/phantom_hit"},
	}
	Mem.ctx.data[ns].advancements[f"{LAB}/orbit_phantom_hit"] = set_json_encoder(Advancement(json_content), max_level=-1)

	write_function(f"{root}/phantom_hit", f"""
advancement revoke @s only {ns}:{LAB}/orbit_phantom_hit
scoreboard players set $strength player_motion.api.launch {PHANTOM_PUSH}
execute at @s facing entity {hole} feet run function player_motion:api/launch_looking
""")


def generate_stop() -> None:
	""" Write the victory and the stop. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/orbit"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/victory", f"""
execute as @r[tag={tag}] at @s run function {ns}:{LAB}/give_star {{trial:"L'orbite"}}
function {root}/stop
""")

	write_function(f"{root}/stop", f"""
kill @e[type=minecraft:item_display,tag={tag}.fragment]
execute as @e[type=minecraft:phantom,tag={tag}.phantom] run tp @s ~ -1000 ~
kill @e[type=minecraft:phantom,tag={tag}.phantom]
execute as @a[tag={tag}] run attribute @s minecraft:gravity base reset
execute as @a[tag={tag}] run attribute @s minecraft:fall_damage_multiplier base reset
clear @a[tag={tag}] *[custom_data~{{{ns}:{{orbit_sword:true}}}}]
tag @a remove {tag}
scoreboard players set #{MODE}_state {ns}.data 0
schedule clear {root}/tick
""")

