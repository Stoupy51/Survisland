""" Trial "Rats de labo": the lab rats escaped, anyone around can catch them and bring them back to their cage.

A rat is an invisible ocelot, which runs away from players, carrying the item display of its model and of a random mini hat.
Hitting a rat catches it: it then floats above the head of its catcher, up to RATS_PER_PLAYER at once.
Clicking the collector lets every carried rat loose in the cage, where barriers built around keep it running.
The rat caging the goal given to spawn_rats, or the last one when there is no goal, gives the star.
Nobody is enrolled, so players can join or leave at any time, and more hands make it faster.
Entering any trial of the lab puts the carried rats back on the ground, free again.

Each collector opens an arena, and a cage or a rat belongs to the arena of the nearest collector when placed,
so several copies of the lab each count their own rats. Place the collector first, then the cage, then the rats.
"""
# ruff: noqa: E501
# Imports
from stewbeet import Advancement, JsonDict, Mem, set_json_encoder, write_function

from user.database.pr_stoupy import RAT_HATS, RAT_VARIANTS, add_rat_hats

from .shared import LAB, crt_text, write_match_predicate

# Constants
MODE: str = "pr_rats"
""" Suffix of the tags, objectives and fake players of the trial. """

RATS_PER_PLAYER: int = 3
""" Rats a player can carry at once. """

CATCH_RADIUS: int = 6
""" Distance from the player within which the rat it just hit is looked for. """

ARENA_RADIUS: int = 48
""" Distance under which a new collector replaces the one of an existing arena instead of opening its own. """

SIZE_RANGE: str = "75..125"
""" Random size of a rat, in percent. """

HITBOX_PER_PERCENT: int = 6
""" Ocelot scale per percent of size, in thousandths: 0.6 at 100 %. """

MODEL_PER_PERCENT: int = 5
""" Model scale per percent of size, in thousandths: 0.5 at 100 %. """

RIDE_OFFSET_PER_PERCENT: int = -17
""" Vertical translation of the model per percent of size, in ten thousandths, bringing it from the ocelot back to the ground. """

MUTANT_SPEED: str = "0.42"
""" Movement speed of the mutant rat, the ocelot one being 0.3. """

CARRY_HEIGHTS: tuple[str, ...] = ("2.1", "2.45", "2.8")
""" Height above the feet of the catcher of each carried rat, by carrying order. """


# Functions
def main() -> None:
	""" Write every function of the rats trial. """
	tag: str = f"{Mem.ctx.project_id}.{MODE}"
	same_arena: str = write_match_predicate(f"{LAB}/rats/same_arena", {f"{tag}.arena": f"#{MODE}_arena"})
	same_carrier: str = write_match_predicate(f"{LAB}/rats/same_carrier", {f"{tag}.id": f"#{MODE}_id"})
	summon_variant: str = "\n".join(f"execute if score #{MODE}_variant {Mem.ctx.project_id}.data matches {index} run function {Mem.ctx.project_id}:{LAB}/rats/summon/{variant}" for index, variant in enumerate(RAT_VARIANTS))
	add_rat_hats()
	generate_placement(same_arena, summon_variant)
	generate_catch()
	generate_release(same_arena, same_carrier, summon_variant)
	generate_tick(same_carrier)
	generate_stop(same_arena, same_carrier)


def generate_placement(same_arena: str, summon_variant: str) -> None:
	""" Write the collector and cage placement, the rat summons, and the random spread of a whole pack. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/rats"
	tag: str = f"{ns}.{MODE}"
	pick_hat: str = "\n".join(f'execute if score #{MODE}_hat {ns}.data matches {index} run data modify entity @s item.components."minecraft:custom_model_data" set value {{strings:["{hat.name}"]}}' for index, hat in enumerate(RAT_HATS))
	no_collector: str = 'tellraw @a[distance=..16] {"text":"Rats : place d\'abord le collecteur (here/place_collector).","color":"red"}'

	write_function(f"{root}/here/place_collector", f"""
# Replaces the collector of an arena within {ARENA_RADIUS} blocks, or opens a new arena
scoreboard objectives add {tag}.arena dummy
scoreboard objectives add {tag}.goal dummy
scoreboard players set #{MODE}_arena {ns}.data 0
scoreboard players operation #{MODE}_arena {ns}.data = @n[type=minecraft:interaction,tag={tag}.collector,distance=..{ARENA_RADIUS}] {tag}.arena
execute if score #{MODE}_arena {ns}.data matches 0 store result score #{MODE}_arena {ns}.data run scoreboard players add #{MODE}_arena_counter {ns}.data 1
kill @e[tag={tag}.collector,{same_arena}]
execute align xyz positioned ~0.5 ~ ~0.5 run function {root}/new_collector
tellraw @a[distance=..16] {{"text":"Rats : collecteur placé (clic gauche ou droit pour déposer les rats portés).","color":"green"}}
""")

	write_function(f"{root}/new_collector", f"""
# A hitbox slightly larger than the block here, so it is clicked before a block built in the same place
summon minecraft:interaction ~ ~-0.05 ~ {{Tags:["{tag}.collector","{tag}.new_collector"],width:1.1f,height:1.1f,response:1b}}
summon minecraft:text_display ~ ~1.3 ~ {{Tags:["{tag}.collector","{tag}.new_collector"],text:{crt_text("Déposer les rats")},billboard:"center",background:0,brightness:{{sky:15,block:15}}}}
scoreboard players operation @e[tag={tag}.new_collector] {tag}.arena = #{MODE}_arena {ns}.data
scoreboard players set @e[type=minecraft:interaction,tag={tag}.new_collector] {tag}.goal 0
tag @e[tag={tag}.new_collector] remove {tag}.new_collector
""")

	write_function(f"{root}/here/place_cage", f"""
# Replaces the cage of the arena of the nearest collector, the rats dropped there are let loose on this block
execute unless entity @e[type=minecraft:interaction,tag={tag}.collector] run return run {no_collector}
scoreboard players operation #{MODE}_arena {ns}.data = @n[type=minecraft:interaction,tag={tag}.collector] {tag}.arena
kill @e[type=minecraft:marker,tag={tag}.cage,{same_arena}]
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function {root}/new_cage
tellraw @a[distance=..16] {{"text":"Rats : cage placée.","color":"green"}}
""")

	write_function(f"{root}/new_cage", f"""
tag @s add {tag}.cage
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
""")

	for index, variant in enumerate(RAT_VARIANTS):
		ocelot_extra: str = f',attributes:[{{id:"minecraft:movement_speed",base:{MUTANT_SPEED}d}}]' if variant == "mutant" else ""
		write_function(f"{root}/summon/{variant}", f"""
# The new rat keeps the {tag}.new tag until the caller resizes it
scoreboard objectives add {tag}.carried dummy
scoreboard objectives add {tag}.id dummy
scoreboard objectives add {tag}.index dummy
scoreboard objectives add {tag}.arena dummy
scoreboard objectives add {tag}.size dummy
scoreboard objectives add {tag}.variant dummy
summon minecraft:ocelot ~ ~ ~ {{Tags:["{tag}.rat","{tag}.new"],PersistenceRequired:1b,Silent:1b,Trusting:0b,Age:0,active_effects:[{{id:"minecraft:invisibility",duration:-1,amplifier:0b,show_particles:0b}},{{id:"minecraft:resistance",duration:-1,amplifier:4b,show_particles:0b}}]{ocelot_extra},Passengers:[{{id:"minecraft:item_display",Tags:["{tag}.model"],item_display:"none",teleport_duration:1,item:{{id:"minecraft:stone",count:1,components:{{"minecraft:item_model":"{ns}:rat_{variant}"}}}}}}]}}
scoreboard players set @e[type=minecraft:ocelot,tag={tag}.new] {tag}.variant {index}
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/resize", f"""
# A new rat of the nearest arena, with a random size in {SIZE_RANGE} % and a random hat
tag @s remove {tag}.new
scoreboard players operation @s {tag}.arena = @n[type=minecraft:interaction,tag={tag}.collector] {tag}.arena
execute store result score @s {tag}.size run random value {SIZE_RANGE}
execute store result score #{MODE}_hat {ns}.data run random value 0..{len(RAT_HATS) - 1}
execute on passengers run function {root}/pick_hat
function {root}/apply_size
""")

	write_function(f"{root}/pick_hat", pick_hat)

	write_function(f"{root}/apply_size", f"""
# Hitbox and model scaled together from the size of @s
scoreboard players operation #{MODE}_hitbox {ns}.data = @s {tag}.size
execute store result storage {ns}:{MODE} size.hitbox double 0.001 run scoreboard players operation #{MODE}_hitbox {ns}.data *= #{HITBOX_PER_PERCENT} {ns}.data
function {root}/apply_hitbox with storage {ns}:{MODE} size
scoreboard players operation #{MODE}_model {ns}.data = @s {tag}.size
scoreboard players operation #{MODE}_model {ns}.data *= #{MODEL_PER_PERCENT} {ns}.data
scoreboard players operation #{MODE}_offset {ns}.data = @s {tag}.size
scoreboard players operation #{MODE}_offset {ns}.data *= #{RIDE_OFFSET_PER_PERCENT} {ns}.data
execute on passengers run function {root}/resize_model
""")

	write_function(f"{root}/apply_hitbox", """
$attribute @s minecraft:scale base set $(hitbox)
""")

	write_function(f"{root}/resize_model", f"""
execute store result entity @s transformation.scale[0] float 0.001 run scoreboard players get #{MODE}_model {ns}.data
execute store result entity @s transformation.scale[1] float 0.001 run scoreboard players get #{MODE}_model {ns}.data
execute store result entity @s transformation.scale[2] float 0.001 run scoreboard players get #{MODE}_model {ns}.data
execute store result entity @s transformation.translation[1] float 0.0001 run scoreboard players get #{MODE}_offset {ns}.data
""")

	write_function(f"{root}/here/place_rat", f"""
# One rat of the given variant ({", ".join(RAT_VARIANTS)}) right here
$function {root}/summon/$(variant)
execute as @e[type=minecraft:ocelot,tag={tag}.new] run function {root}/resize
""")

	write_function(f"{root}/here/spawn_rats", f"""
# $(count) rats of random variants, spread on the ground within $(radius) blocks, never above three blocks over this one
# $(goal) of them to cage for the star, 0 for all of them
execute unless entity @e[type=minecraft:interaction,tag={tag}.collector] run return run {no_collector}
$scoreboard players set @n[type=minecraft:interaction,tag={tag}.collector] {tag}.goal $(goal)
$scoreboard players set #{MODE}_to_spawn {ns}.data $(count)
$data modify storage {ns}:{MODE} spread.radius set value $(radius)
function {root}/spawn_loop
execute summon minecraft:marker run function {root}/spread_height
function {root}/spread with storage {ns}:{MODE} spread
""")

	write_function(f"{root}/spawn_loop", f"""
execute store result score #{MODE}_variant {ns}.data run random value 0..{len(RAT_VARIANTS) - 1}
{summon_variant}
tag @e[type=minecraft:ocelot,tag={tag}.new] add {tag}.spreading
execute as @e[type=minecraft:ocelot,tag={tag}.new] run function {root}/resize
scoreboard players remove #{MODE}_to_spawn {ns}.data 1
execute if score #{MODE}_to_spawn {ns}.data matches 1.. run function {root}/spawn_loop
""")

	write_function(f"{root}/spread_height", f"""
function #bs.position:get_pos {{scale:1}}
execute store result storage {ns}:{MODE} spread.max_y int 1 run scoreboard players add @s bs.pos.y 3
kill @s
""")

	write_function(f"{root}/spread", f"""
$spreadplayers ~ ~ 1 $(radius) under $(max_y) false @e[type=minecraft:ocelot,tag={tag}.spreading]
tag @e[type=minecraft:ocelot,tag={tag}.spreading] remove {tag}.spreading
""")


def generate_catch() -> None:
	""" Write the catch, triggered by a player hitting a rat. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/rats"
	tag: str = f"{ns}.{MODE}"

	json_content: JsonDict = {
		"criteria": {"requirement": {"trigger": "minecraft:player_hurt_entity", "conditions": {"entity": [
			{"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"entity_type": "minecraft:ocelot", "entity_tags": {"all_of": [f"{tag}.rat"]}}}
		]}}},
		"rewards": {"function": f"{root}/hit"},
	}
	Mem.ctx.data[ns].advancements[f"{LAB}/rats_hit"] = set_json_encoder(Advancement(json_content), max_level=-1)

	write_function(f"{root}/hit", f"""
advancement revoke @s only {ns}:{LAB}/rats_hit
execute if score @s {tag}.carried matches {RATS_PER_PLAYER}.. run return run title @s actionbar {{"text":"Tu portes déjà {RATS_PER_PLAYER} rats, va les mettre en cage !","color":"red"}}

# The rat just hit is the one whose last attacker is this player, never one already caged
tag @s add {tag}.catching
execute as @e[type=minecraft:ocelot,tag={tag}.rat,tag=!{tag}.caged,distance=..{CATCH_RADIUS}] at @s on attacker if entity @s[tag={tag}.catching] run tag @n[type=minecraft:ocelot,tag={tag}.rat,distance=..0.01] add {tag}.caught
tag @s remove {tag}.catching
execute if entity @e[type=minecraft:ocelot,tag={tag}.caught] run function {root}/catch
tag @e[type=minecraft:ocelot,tag={tag}.caught] remove {tag}.caught
""")

	write_function(f"{root}/catch", f"""
# @s is the catcher: the model of the rat is copied onto a display floating above its head, then the rat is gone
execute unless score @s {tag}.id matches 1.. store result score @s {tag}.id run scoreboard players add #{MODE}_id_counter {ns}.data 1
scoreboard players add @s {tag}.carried 1
scoreboard players operation #{MODE}_id {ns}.data = @s {tag}.id
scoreboard players operation #{MODE}_index {ns}.data = @s {tag}.carried
execute as @n[type=minecraft:ocelot,tag={tag}.caught] on passengers run data modify storage {ns}:{MODE} model set from entity @s
execute at @s summon minecraft:item_display run function {root}/new_carried
execute as @n[type=minecraft:ocelot,tag={tag}.caught] run function {root}/remove_rat
playsound minecraft:entity.rabbit.hurt neutral @a[distance=..16] ~ ~ ~ 1 1.6
title @s actionbar [{{"text":"Rats portés : ","color":"gray"}},{{"score":{{"name":"@s","objective":"{tag}.carried"}},"color":"aqua"}},{{"text":"/{RATS_PER_PLAYER}","color":"aqua"}}]
""")

	write_function(f"{root}/new_carried", f"""
# The arena, size and variant of the rat are kept to bring it back to life when it is dropped
tag @s add {tag}.carried
data modify entity @s item set from storage {ns}:{MODE} model.item
data modify entity @s transformation set from storage {ns}:{MODE} model.transformation
data modify entity @s transformation.translation set value [0.0f,0.0f,0.0f]
data modify entity @s teleport_duration set value 1
scoreboard players operation @s {tag}.id = #{MODE}_id {ns}.data
scoreboard players operation @s {tag}.index = #{MODE}_index {ns}.data
scoreboard players operation @s {tag}.arena = @n[type=minecraft:ocelot,tag={tag}.caught] {tag}.arena
scoreboard players operation @s {tag}.size = @n[type=minecraft:ocelot,tag={tag}.caught] {tag}.size
scoreboard players operation @s {tag}.variant = @n[type=minecraft:ocelot,tag={tag}.caught] {tag}.variant
""")

	write_function(f"{root}/remove_rat", """
execute on passengers run kill @s
tp @s ~ -1000 ~
kill @s
""")


def generate_release(same_arena: str, same_carrier: str, summon_variant: str) -> None:
	""" Write the drop of the carried rats, in the cage by the collector or on the ground by the start of a trial. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/rats"
	tag: str = f"{ns}.{MODE}"
	caged_count: str = f'{{"score":{{"name":"#{MODE}_caged","objective":"{ns}.data"}},"color":"aqua"}}'

	for trigger, name in (("minecraft:player_hurt_entity", "hit"), ("minecraft:player_interacted_with_entity", "use")):
		json_content: JsonDict = {
			"criteria": {"requirement": {"trigger": trigger, "conditions": {"entity": [
				{"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"entity_type": "minecraft:interaction", "entity_tags": {"all_of": [f"{tag}.collector"]}}},
			]}}},
			"rewards": {"function": f"{root}/collect"},
		}
		Mem.ctx.data[ns].advancements[f"{LAB}/rats_{name}_collector"] = set_json_encoder(Advancement(json_content), max_level=-1)

	write_function(f"{root}/collect", f"""
# @s clicked the collector of its arena: its rats run free again in the cage
advancement revoke @s only {ns}:{LAB}/rats_hit_collector
advancement revoke @s only {ns}:{LAB}/rats_use_collector
execute unless score @s {tag}.carried matches 1.. run return run title @s actionbar {{"text":"Frappe des rats pour les attraper, puis reviens ici.","color":"red"}}
scoreboard players operation #{MODE}_arena {ns}.data = @n[type=minecraft:interaction,tag={tag}.collector] {tag}.arena
execute unless entity @e[type=minecraft:marker,tag={tag}.cage,{same_arena}] run return run title @s actionbar {{"text":"Ce collecteur n'a pas de cage (here/place_cage).","color":"red"}}
scoreboard players operation #{MODE}_id {ns}.data = @s {tag}.id
execute at @n[type=minecraft:marker,tag={tag}.cage,{same_arena}] as @e[type=minecraft:item_display,tag={tag}.carried,{same_carrier}] run function {root}/release_one
tag @e[type=minecraft:ocelot,tag={tag}.released] add {tag}.caged
tag @e[type=minecraft:ocelot,tag={tag}.released] remove {tag}.released
scoreboard players set @s {tag}.carried 0
playsound minecraft:block.iron_door.close block @a[distance=..16] ~ ~ ~ 1 1.2

execute store result score #{MODE}_caged {ns}.data if entity @e[type=minecraft:ocelot,tag={tag}.caged,{same_arena}]
scoreboard players operation #{MODE}_goal {ns}.data = @n[type=minecraft:interaction,tag={tag}.collector,{same_arena}] {tag}.goal
execute if score #{MODE}_goal {ns}.data matches 1.. run title @a[distance=..16] actionbar [{{"text":"Rats en cage : ","color":"gray"}},{caged_count},{{"text":"/","color":"aqua"}},{{"score":{{"name":"#{MODE}_goal","objective":"{ns}.data"}},"color":"aqua"}}]
execute if score #{MODE}_goal {ns}.data matches 0 run title @a[distance=..16] actionbar [{{"text":"Rats en cage : ","color":"gray"}},{caged_count}]
execute if score #{MODE}_goal {ns}.data matches 1.. if score #{MODE}_caged {ns}.data >= #{MODE}_goal {ns}.data run return run function {root}/victory
execute unless entity @e[type=minecraft:ocelot,tag={tag}.rat,tag=!{tag}.caged,{same_arena}] unless entity @e[type=minecraft:item_display,tag={tag}.carried,{same_arena}] run function {root}/victory
""")

	write_function(f"{root}/release", f"""
# @s enters a trial: the rats on its head run free again where it stands
execute unless score @s {tag}.carried matches 1.. run return 0
scoreboard players operation #{MODE}_id {ns}.data = @s {tag}.id
execute as @e[type=minecraft:item_display,tag={tag}.carried,{same_carrier}] run function {root}/release_one
tag @e[type=minecraft:ocelot,tag={tag}.released] remove {tag}.released
scoreboard players set @s {tag}.carried 0
""")

	write_function(f"{root}/release_one", f"""
# @s is a carried display: the rat it shows comes back to life here, tagged {tag}.released for the caller
scoreboard players operation #{MODE}_variant {ns}.data = @s {tag}.variant
data modify storage {ns}:{MODE} item set from entity @s item
{summon_variant}
scoreboard players operation @e[type=minecraft:ocelot,tag={tag}.new] {tag}.arena = @s {tag}.arena
scoreboard players operation @e[type=minecraft:ocelot,tag={tag}.new] {tag}.size = @s {tag}.size
execute as @e[type=minecraft:ocelot,tag={tag}.new] run function {root}/restore
kill @s
""")

	write_function(f"{root}/restore", f"""
tag @s remove {tag}.new
tag @s add {tag}.released
execute on passengers run data modify entity @s item set from storage {ns}:{MODE} item
function {root}/apply_size
""")


def generate_tick(same_carrier: str) -> None:
	""" Write the tick: rats looking where they run, and carried rats following their catcher. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/rats"
	tag: str = f"{ns}.{MODE}"
	carry: str = "\n".join(f"execute if score @s {tag}.index matches {index} run tp @s ~ ~{height} ~ ~ 0" for index, height in enumerate(CARRY_HEIGHTS, start=1))

	write_function(f"{root}/tick", f"""
execute as @e[type=minecraft:ocelot,tag={tag}.rat] at @s on passengers run rotate @s ~ 0
execute as @a[scores={{{tag}.carried=1..}}] at @s run function {root}/carry

# Alive while a rat runs or rides a head, any new rat brings the tick back
execute if entity @e[type=minecraft:ocelot,tag={tag}.rat] run return run schedule function {root}/tick 1t replace
execute if entity @e[type=minecraft:item_display,tag={tag}.carried] run schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/carry", f"""
scoreboard players operation #{MODE}_id {ns}.data = @s {tag}.id
execute as @e[type=minecraft:item_display,tag={tag}.carried,{same_carrier}] run function {root}/carry_one
""")

	write_function(f"{root}/carry_one", f"""
# Stacked above the head of the catcher, facing where it looks
{carry}
""")


def generate_stop(same_arena: str, same_carrier: str) -> None:
	""" Write the victory, and the stops clearing the rats of the nearest arena or of all of them. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/rats"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/victory", f"""
# The rats still free or carried are gone once the goal is met, the caged ones stay
function {ns}:{LAB}/give_star {{trial:"Les rats de labo"}}
execute as @e[type=minecraft:ocelot,tag={tag}.rat,tag=!{tag}.caged,{same_arena}] run function {root}/remove_rat
kill @e[type=minecraft:item_display,tag={tag}.carried,{same_arena}]
execute as @a[scores={{{tag}.carried=1..}}] run function {root}/recount
""")

	write_function(f"{root}/here/stop", f"""
# The arena of the nearest collector: its rats, free, carried or caged, then the carriers count what they still hold
scoreboard players operation #{MODE}_arena {ns}.data = @n[type=minecraft:interaction,tag={tag}.collector] {tag}.arena
execute as @e[type=minecraft:ocelot,tag={tag}.rat,{same_arena}] run function {root}/remove_rat
kill @e[type=minecraft:item_display,tag={tag}.carried,{same_arena}]
execute as @a[scores={{{tag}.carried=1..}}] run function {root}/recount
""")

	write_function(f"{root}/recount", f"""
scoreboard players operation #{MODE}_id {ns}.data = @s {tag}.id
execute store result score @s {tag}.carried if entity @e[type=minecraft:item_display,tag={tag}.carried,{same_carrier}]
""")

	write_function(f"{root}/stop", f"""
# Every arena, everywhere
execute as @e[type=minecraft:ocelot,tag={tag}.rat] run function {root}/remove_rat
kill @e[type=minecraft:item_display,tag={tag}.carried]
scoreboard players reset * {tag}.carried
schedule clear {root}/tick
""")

