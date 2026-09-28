
#> survisland:modes/pr_stoupy/breakout/death
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/breakout/ball_tick
#

# @s is the ball that fell, lost for nothing while its player has another one in play
scoreboard players operation #pr_breakout_slot survisland.data = @s survisland.pr_breakout
tag @s add survisland.pr_breakout.lost
execute if entity @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,tag=!survisland.pr_breakout.lost,predicate=survisland:modes/pr_stoupy/breakout/same_slot] run return run kill @s

# Its last ball: every ball of the arena is taken back and relaunched after the countdown
# The name of its player is resolved on the ball's own item, since a text set on the screen is never resolved
execute if score @s survisland.pr_breakout.color matches 0 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "white"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 1 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "gold"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 2 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "light_purple"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 3 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "aqua"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 4 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "yellow"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 5 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "green"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 6 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "light_purple"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 7 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "dark_gray"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 8 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "gray"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 9 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "dark_aqua"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 10 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "dark_purple"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 11 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "blue"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 12 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "gold"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 13 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "dark_green"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 14 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "red"}, {"text": " est mort !", "color": "#01FE41"}]}
execute if score @s survisland.pr_breakout.color matches 15 run item modify entity @s armor.body {"function": "minecraft:set_name", "entity": "this", "target": "custom_name", "name": [{"selector": "@a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_slot]", "color": "black"}, {"text": " est mort !", "color": "#01FE41"}]}
data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set from entity @s equipment.body.components."minecraft:custom_name"
kill @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
scoreboard players set #pr_breakout_state survisland.data 1
scoreboard players set #pr_breakout_timer survisland.data 140
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:entity.generic.explode master @s ~ ~ ~ 0.6 1.4

