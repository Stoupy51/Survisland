""" Trial "Rats de labo": the lab rats escaped, anyone around can catch them and bring them back to a cage.

A rat is an invisible ocelot, which runs away from players, carrying the item display of its model and of a random mini hat.
Hitting a rat catches it: it then floats above the head of its catcher, up to RATS_PER_PLAYER at once.
Standing next to a cage drops every carried rat inside. The last rat caged gives the star.
Nobody is enrolled, so players can join or leave at any time, and more hands make it faster.

Cages placed within CAGE_GROUP_RADIUS of each other form an arena, and a rat belongs to the arena of the nearest cage
when summoned, so several copies of the lab each count their own rats. Place the cages before the rats.
"""
# ruff: noqa: E501
# Imports
from stewbeet import Advancement, JsonDict, Mem, set_json_encoder, write_function

from user.database.pr_stoupy import RAT_HATS, RAT_VARIANTS, add_rat_hats

from .shared import LAB, write_match_predicate

# Constants
MODE: str = "pr_rats"
""" Suffix of the tags, objectives and fake players of the trial. """

RATS_PER_PLAYER: int = 3
""" Rats a player can carry at once. """

CATCH_RADIUS: int = 6
""" Distance from the player within which the rat it just hit is looked for. """

CAGE_RADIUS: str = "2.5"
""" Distance to a cage marker at which carried rats are dropped inside. """

CAGE_GROUP_RADIUS: int = 48
""" Distance under which a new cage joins the arena of an existing one instead of opening its own. """

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

CAGE_GRID: int = 4
""" Rats per side of the square a cage lays its rats on. """

CAGE_SPACING: float = 0.45
""" Blocks between two rats in a cage. """


# Functions
def main() -> None:
	""" Write every function of the rats trial. """
	tag: str = f"{Mem.ctx.project_id}.{MODE}"
	same_arena: str = write_match_predicate(f"{LAB}/rats/same_arena", {f"{tag}.arena": f"#{MODE}_arena"})
	same_carrier: str = write_match_predicate(f"{LAB}/rats/same_carrier", {f"{tag}.id": f"#{MODE}_id"})
	add_rat_hats()
	generate_placement()
	generate_catch()
	generate_tick(same_arena, same_carrier)
	generate_stop(same_arena, same_carrier)


def generate_placement() -> None:
	""" Write the rat summons, the random spread of a whole pack, and the cage placement. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/rats"
	tag: str = f"{ns}.{MODE}"
	pick_hat: str = "\n".join(f'execute if score #{MODE}_hat {ns}.data matches {index} run data modify entity @s item.components."minecraft:custom_model_data" set value {{strings:["{hat.name}"]}}' for index, hat in enumerate(RAT_HATS))
	random_variant: str = "\n".join(f"execute if score #{MODE}_variant {ns}.data matches {index} run function {root}/summon/{variant}" for index, variant in enumerate(RAT_VARIANTS))

	for variant in RAT_VARIANTS:
		mutant: bool = variant == "mutant"
		display_extra: str = ",Glowing:1b,glow_color_override:8453920" if mutant else ""
		ocelot_extra: str = f',attributes:[{{id:"minecraft:movement_speed",base:{MUTANT_SPEED}d}}]' if mutant else ""
		write_function(f"{root}/summon/{variant}", f"""
scoreboard objectives add {tag}.carried dummy
scoreboard objectives add {tag}.id dummy
scoreboard objectives add {tag}.index dummy
scoreboard objectives add {tag}.arena dummy
summon minecraft:ocelot ~ ~ ~ {{Tags:["{tag}.rat","{tag}.new"],PersistenceRequired:1b,Silent:1b,Trusting:0b,Age:0,active_effects:[{{id:"minecraft:invisibility",duration:-1,amplifier:0b,show_particles:0b}},{{id:"minecraft:resistance",duration:-1,amplifier:4b,show_particles:0b}}]{ocelot_extra},Passengers:[{{id:"minecraft:item_display",Tags:["{tag}.model"],item_display:"none",teleport_duration:1,item:{{id:"minecraft:stone",count:1,components:{{"minecraft:item_model":"{ns}:rat_{variant}"}}}}{display_extra}}}]}}
execute as @e[type=minecraft:ocelot,tag={tag}.new] run function {root}/resize
schedule function {root}/tick 1t replace
""")

	write_function(f"{root}/resize", f"""
tag @s remove {tag}.new
scoreboard players operation @s {tag}.arena = @n[type=minecraft:marker,tag={tag}.cage] {tag}.arena

# Hitbox and model scaled together, from {SIZE_RANGE} %
execute store result score #{MODE}_size {ns}.data run random value {SIZE_RANGE}
scoreboard players operation #{MODE}_hitbox {ns}.data = #{MODE}_size {ns}.data
execute store result storage {ns}:{MODE} size.hitbox double 0.001 run scoreboard players operation #{MODE}_hitbox {ns}.data *= #{HITBOX_PER_PERCENT} {ns}.data
function {root}/apply_hitbox with storage {ns}:{MODE} size
scoreboard players operation #{MODE}_model {ns}.data = #{MODE}_size {ns}.data
scoreboard players operation #{MODE}_model {ns}.data *= #{MODEL_PER_PERCENT} {ns}.data
scoreboard players operation #{MODE}_offset {ns}.data = #{MODE}_size {ns}.data
scoreboard players operation #{MODE}_offset {ns}.data *= #{RIDE_OFFSET_PER_PERCENT} {ns}.data
execute store result score #{MODE}_hat {ns}.data run random value 0..{len(RAT_HATS) - 1}
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
{pick_hat}
""")

	write_function(f"{root}/here/place_rat", f"""
# One rat of the given variant ({", ".join(RAT_VARIANTS)}) right here
$function {root}/summon/$(variant)
""")

	write_function(f"{root}/here/spawn_rats", f"""
# $(count) rats of random variants, spread on the ground within $(radius) blocks, never above three blocks over this one
$scoreboard players set #{MODE}_to_spawn {ns}.data $(count)
$data modify storage {ns}:{MODE} spread.radius set value $(radius)
function {root}/spawn_loop
execute summon minecraft:marker run function {root}/spread_height
function {root}/spread with storage {ns}:{MODE} spread
""")

	write_function(f"{root}/spawn_loop", f"""
execute store result score #{MODE}_variant {ns}.data run random value 0..{len(RAT_VARIANTS) - 1}
{random_variant}
tag @e[type=minecraft:ocelot,tag={tag}.rat,distance=..0.1] add {tag}.spreading
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

	write_function(f"{root}/here/place_cage", f"""
# Joins the arena of a cage within {CAGE_GROUP_RADIUS} blocks, or opens a new one
scoreboard objectives add {tag}.arena dummy
scoreboard objectives add {tag}.caged dummy
scoreboard players set #{MODE}_arena {ns}.data 0
scoreboard players operation #{MODE}_arena {ns}.data = @n[type=minecraft:marker,tag={tag}.cage,distance=..{CAGE_GROUP_RADIUS}] {tag}.arena
execute if score #{MODE}_arena {ns}.data matches 0 store result score #{MODE}_arena {ns}.data run scoreboard players add #{MODE}_arena_counter {ns}.data 1
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function {root}/new_cage
tellraw @a[distance=..16] {{"text":"Rats : cage placée.","color":"green"}}
""")

	write_function(f"{root}/new_cage", f"""
tag @s add {tag}.cage
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
scoreboard players set @s {tag}.caged 0
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

# The rat just hit is the one whose last attacker is this player
tag @s add {tag}.catching
execute as @e[type=minecraft:ocelot,tag={tag}.rat,distance=..{CATCH_RADIUS}] at @s on attacker if entity @s[tag={tag}.catching] run tag @n[type=minecraft:ocelot,tag={tag}.rat,distance=..0.01] add {tag}.caught
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
scoreboard players operation #{MODE}_arena {ns}.data = @n[type=minecraft:ocelot,tag={tag}.caught] {tag}.arena

execute as @n[type=minecraft:ocelot,tag={tag}.caught] on passengers run data modify storage {ns}:{MODE} model set from entity @s
execute at @s summon minecraft:item_display run function {root}/new_carried
execute as @n[type=minecraft:ocelot,tag={tag}.caught] run function {root}/remove_rat
playsound minecraft:entity.rabbit.hurt neutral @a[distance=..16] ~ ~ ~ 1 1.6
title @s actionbar [{{"text":"Rats portés : ","color":"gray"}},{{"score":{{"name":"@s","objective":"{tag}.carried"}},"color":"aqua"}},{{"text":"/{RATS_PER_PLAYER}","color":"aqua"}}]
""")

	write_function(f"{root}/new_carried", f"""
tag @s add {tag}.carried
data modify entity @s item set from storage {ns}:{MODE} model.item
data modify entity @s transformation set from storage {ns}:{MODE} model.transformation
data modify entity @s transformation.translation set value [0.0f,0.0f,0.0f]
data modify entity @s Glowing set from storage {ns}:{MODE} model.Glowing
data modify entity @s glow_color_override set from storage {ns}:{MODE} model.glow_color_override
data modify entity @s teleport_duration set value 1
scoreboard players operation @s {tag}.id = #{MODE}_id {ns}.data
scoreboard players operation @s {tag}.index = #{MODE}_index {ns}.data
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
""")

	write_function(f"{root}/remove_rat", """
execute on passengers run kill @s
tp @s ~ -1000 ~
kill @s
""")


def generate_tick(same_arena: str, same_carrier: str) -> None:
	""" Write the tick: rats looking where they run, carried rats following their catcher, and the cages. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/rats"
	tag: str = f"{ns}.{MODE}"
	carry: str = "\n".join(f"execute if score @s {tag}.index matches {index} run tp @s ~ ~{height} ~ ~ 0" for index, height in enumerate(CARRY_HEIGHTS, start=1))
	cage_slots: str = "\n".join(
		f"execute if score #{MODE}_slot {ns}.data matches {slot} run tp @s ~{(slot % CAGE_GRID - (CAGE_GRID - 1) / 2) * CAGE_SPACING:.2f} ~ ~{(slot // CAGE_GRID - (CAGE_GRID - 1) / 2) * CAGE_SPACING:.2f} {slot * 137 % 360} 0"
		for slot in range(CAGE_GRID * CAGE_GRID)
	)

	write_function(f"{root}/tick", f"""
execute as @e[type=minecraft:ocelot,tag={tag}.rat] at @s on passengers run rotate @s ~ 0
execute as @a[scores={{{tag}.carried=1..}}] at @s run function {root}/carry
execute as @e[type=minecraft:marker,tag={tag}.cage] at @s as @a[scores={{{tag}.carried=1..}},distance=..{CAGE_RADIUS}] run function {root}/drop_in_cage

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

	write_function(f"{root}/drop_in_cage", f"""
# Positioned on the cage, @s is a player carrying rats: they join the arena of the cage and fill its next slots
scoreboard players operation #{MODE}_id {ns}.data = @s {tag}.id
scoreboard players operation #{MODE}_arena {ns}.data = @n[type=minecraft:marker,tag={tag}.cage,distance=..0.1] {tag}.arena
scoreboard players operation #{MODE}_caged {ns}.data = @n[type=minecraft:marker,tag={tag}.cage,distance=..0.1] {tag}.caged
execute as @e[type=minecraft:item_display,tag={tag}.carried,{same_carrier}] run function {root}/cage_one
scoreboard players operation @n[type=minecraft:marker,tag={tag}.cage,distance=..0.1] {tag}.caged = #{MODE}_caged {ns}.data
scoreboard players set @s {tag}.carried 0
playsound minecraft:block.iron_door.close block @a[distance=..16] ~ ~ ~ 1 1.2
execute unless entity @e[type=minecraft:ocelot,tag={tag}.rat,{same_arena}] unless entity @e[type=minecraft:item_display,tag={tag}.carried,{same_arena}] run function {root}/victory
""")

	write_function(f"{root}/cage_one", f"""
tag @s remove {tag}.carried
tag @s add {tag}.caged
scoreboard players operation @s {tag}.arena = #{MODE}_arena {ns}.data
scoreboard players operation #{MODE}_slot {ns}.data = #{MODE}_caged {ns}.data
scoreboard players operation #{MODE}_slot {ns}.data %= #{CAGE_GRID * CAGE_GRID} {ns}.data
scoreboard players add #{MODE}_caged {ns}.data 1
{cage_slots}
""")


def generate_stop(same_arena: str, same_carrier: str) -> None:
	""" Write the victory, and the stops clearing the rats of the nearest arena or of all of them. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}/rats"
	tag: str = f"{ns}.{MODE}"

	write_function(f"{root}/victory", f"""
function {ns}:{LAB}/give_star {{trial:"Les rats de labo"}}
""")

	write_function(f"{root}/here/stop", f"""
# The arena of the nearest cage: its rats, free, carried or caged, then the carriers count what they still hold
scoreboard players operation #{MODE}_arena {ns}.data = @n[type=minecraft:marker,tag={tag}.cage] {tag}.arena
execute as @e[type=minecraft:ocelot,tag={tag}.rat,{same_arena}] run function {root}/remove_rat
kill @e[type=minecraft:item_display,tag={tag}.carried,{same_arena}]
kill @e[type=minecraft:item_display,tag={tag}.caged,{same_arena}]
scoreboard players set @e[type=minecraft:marker,tag={tag}.cage,{same_arena}] {tag}.caged 0
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
kill @e[type=minecraft:item_display,tag={tag}.caged]
scoreboard players reset * {tag}.carried
scoreboard players set @e[type=minecraft:marker,tag={tag}.cage] {tag}.caged 0
schedule clear {root}/tick
""")

