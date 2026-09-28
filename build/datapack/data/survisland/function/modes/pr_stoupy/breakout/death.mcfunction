
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
execute if score @s survisland.pr_breakout.color matches 0 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur blanc", "color": "white"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 1 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur orange", "color": "gold"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 2 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur magenta", "color": "light_purple"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 3 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur bleu clair", "color": "aqua"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 4 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur jaune", "color": "yellow"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 5 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur vert clair", "color": "green"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 6 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur rose", "color": "light_purple"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 7 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur gris", "color": "dark_gray"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 8 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur gris clair", "color": "gray"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 9 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur cyan", "color": "dark_aqua"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 10 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur violet", "color": "dark_purple"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 11 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur bleu", "color": "blue"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 12 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur marron", "color": "gold"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 13 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur vert", "color": "dark_green"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 14 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur rouge", "color": "red"}, {"text": " est mort !", "color": "#01FE41"}]
execute if score @s survisland.pr_breakout.color matches 15 run data modify entity @n[type=minecraft:text_display,tag=survisland.pr_breakout.screen,predicate=survisland:modes/pr_stoupy/breakout/same_arena] text set value [{"text": "Joueur noir", "color": "black"}, {"text": " est mort !", "color": "#01FE41"}]
kill @e[type=minecraft:sulfur_cube,tag=survisland.pr_breakout.ball,predicate=survisland:modes/pr_stoupy/breakout/same_arena]
scoreboard players set #pr_breakout_state survisland.data 1
scoreboard players set #pr_breakout_timer survisland.data 140
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:entity.generic.explode master @s ~ ~ ~ 0.6 1.4

