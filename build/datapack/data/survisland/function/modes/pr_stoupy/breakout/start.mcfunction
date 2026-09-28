
#> survisland:modes/pr_stoupy/breakout/start
#
# @within	string in survisland:modes/pr_stoupy/breakout/example/frame {tp:"~ ~5 ~",redstone:""}
#
# @args		tp (string)
#			redstone (string)
#

# Safe to fire every tick: the nearest field starts once idle with 4 free players on the start pads
# $(tp) moves each player onto its colored block, read right after, "" to read it under the pad
# $(redstone) is where a redstone block is placed on victory, relative to the caller, "" for none
execute unless entity @e[type=minecraft:marker,tag=survisland.pr_breakout.corner] run return 0
execute if score @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] survisland.pr_breakout.state matches 1.. run return 0
execute store result score #pr_breakout_free survisland.data if entity @a[tag=!survisland.pr_breakout,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,gamemode=!spectator]
execute unless score #pr_breakout_free survisland.data matches 1.. run return run scoreboard players set @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] survisland.pr_breakout.wait 0
execute unless score #pr_breakout_free survisland.data matches 1.. run return 0
execute unless score #pr_stoupy_solo survisland.data matches 1 unless score #pr_breakout_free survisland.data matches 4.. run return 0
function survisland:modes/pr_stoupy/breakout/objectives
execute if score #pr_breakout_free survisland.data matches ..3 run scoreboard players add @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] survisland.pr_breakout.wait 1
execute if score #pr_breakout_free survisland.data matches ..3 if score @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] survisland.pr_breakout.wait matches ..19 run return 0
scoreboard players set @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] survisland.pr_breakout.wait 0
execute as @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] run function survisland:modes/pr_stoupy/breakout/load_arena

tag @a[tag=!survisland.pr_breakout,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,gamemode=!spectator,limit=4,sort=nearest] add survisland.pr_breakout.new
$data modify storage survisland:pr_stoupy tp set value "$(tp)"
execute as @a[tag=survisland.pr_breakout.new] at @s run function survisland:modes/pr_stoupy/teleport

# Slots go from the start of the field to its end, the closest player to the first cell being the Joueur 1
scoreboard players set #pr_breakout_slot_counter survisland.data 0
execute at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] as @a[tag=survisland.pr_breakout.new,sort=nearest] at @s run function survisland:modes/pr_stoupy/breakout/enroll_player
tag @a remove survisland.pr_breakout.new
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=-1}] run return run function survisland:modes/pr_stoupy/breakout/abort_colorless
execute as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] at @s run function survisland:modes/pr_stoupy/breakout/place_screen

# Fewer players than needed only happens in solo mode, where every ball breaks every solo color
scoreboard players set #pr_breakout_solo survisland.data 0
execute if score #pr_breakout_free survisland.data matches ..3 run scoreboard players set #pr_breakout_solo survisland.data 1

execute as @e[type=minecraft:marker,tag=survisland.pr_breakout.redstone,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run function survisland:modes/pr_stoupy/breakout/forget_redstone
$data modify storage survisland:pr_breakout redstone set value "$(redstone)"
execute unless data storage survisland:pr_breakout {redstone:""} run function survisland:modes/pr_stoupy/breakout/place_redstone with storage survisland:pr_breakout

scoreboard players set #pr_breakout_broken survisland.data 0
scoreboard players set #pr_breakout_bonus survisland.data 0
scoreboard players set #pr_breakout_level survisland.data 1
function survisland:modes/pr_stoupy/breakout/begin_level
execute as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] run function survisland:modes/pr_stoupy/breakout/save_arena
schedule function survisland:modes/pr_stoupy/breakout/tick 1t replace

