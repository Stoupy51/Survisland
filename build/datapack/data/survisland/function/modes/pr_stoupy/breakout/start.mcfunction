
#> survisland:modes/pr_stoupy/breakout/start
#
# @within	string in survisland:modes/pr_stoupy/breakout/example/frame
#

# Safe to fire every tick: the nearest field starts once idle with 4 free players standing on a colored block
execute unless entity @e[type=minecraft:marker,tag=survisland.pr_breakout.corner] run return 0
execute if score @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] survisland.pr_breakout.state matches 1.. run return 0
execute store result score #pr_breakout_free survisland.data if entity @a[tag=!survisland.pr_breakout,distance=..16,predicate=survisland:modes/pr_stoupy/breakout/on_brick,gamemode=!creative,gamemode=!spectator]
execute unless score #pr_breakout_free survisland.data matches 1.. run return 0
execute unless score #pr_stoupy_solo survisland.data matches 1 unless score #pr_breakout_free survisland.data matches 4.. run return 0
execute as @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] run function survisland:modes/pr_stoupy/breakout/load_arena

# Slots go from the start of the field to its end, the closest player to the first cell being the Joueur 1
tag @a[tag=!survisland.pr_breakout,distance=..16,predicate=survisland:modes/pr_stoupy/breakout/on_brick,gamemode=!creative,gamemode=!spectator,limit=4,sort=nearest] add survisland.pr_breakout.new
scoreboard players set #pr_breakout_slot_counter survisland.data 0
execute at @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] as @a[tag=survisland.pr_breakout.new,sort=nearest] at @s run function survisland:modes/pr_stoupy/breakout/enroll_player
tag @a remove survisland.pr_breakout.new
execute if entity @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout.color=-1}] run return run function survisland:modes/pr_stoupy/breakout/abort_colorless

scoreboard players set #pr_breakout_level survisland.data 1
function survisland:modes/pr_stoupy/breakout/begin_level
execute as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,predicate=survisland:modes/pr_stoupy/breakout/same_arena,limit=1] run function survisland:modes/pr_stoupy/breakout/save_arena
schedule function survisland:modes/pr_stoupy/breakout/tick 1t replace

schedule function survisland:modes/pr_stoupy/door/tick 1t replace

