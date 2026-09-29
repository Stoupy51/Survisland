
#> survisland:modes/pr_stoupy/breakout/level_cleared
#
# @executed	positioned ^ ^0.2 ^0.5
#
# @within	survisland:modes/pr_stoupy/breakout/break_brick
#

kill @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
# Left in place until the next level block replaces it, or the next start takes it back
execute at @e[type=minecraft:marker,tag=survisland.pr_breakout.level_block,predicate=survisland:modes/pr_stoupy/breakout/same_arena] run setblock ~ ~ ~ minecraft:redstone_block
execute if score #pr_breakout_level survisland.data matches 3.. run return run function survisland:modes/pr_stoupy/breakout/victory
scoreboard players set #pr_breakout_state survisland.data 3
data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Niveau ", "color": "#01FE41"}, {"score": {"name": "#pr_breakout_level", "objective": "survisland.data"}, "color": "#01FE41"}, {"text": " terminé !", "color": "#01FE41"}]
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:entity.player.levelup ambient @s
tellraw @a[distance=..64] {"text":"Casse-briques : niveau terminé, lance /function survisland:modes/pr_stoupy/breakout/here/next_level","color":"gray","italic":true}

