
#> survisland:modes/pr_stoupy/breakout/here/setup
#
# @within	???
#
# @args		width (unknown)
#			height (unknown)
#			invert (unknown)
#			axis (unknown)
#

# Positioned on the bottom left cell of the field, width and height in blocks, axis along which the field extends
scoreboard objectives add survisland.pr_breakout dummy
scoreboard objectives add survisland.pr_breakout.color dummy
scoreboard objectives add survisland.pr_breakout.mu dummy
scoreboard objectives add survisland.pr_breakout.mv dummy
scoreboard objectives add survisland.pr_breakout.u dummy
scoreboard objectives add survisland.pr_breakout.arena dummy
scoreboard objectives add survisland.pr_breakout.state dummy
scoreboard objectives add survisland.pr_breakout.timer dummy
scoreboard objectives add survisland.pr_breakout.level dummy
scoreboard objectives add survisland.pr_breakout.clock dummy
scoreboard objectives add survisland.pr_breakout.axis dummy
scoreboard objectives add survisland.pr_breakout.width dummy
scoreboard objectives add survisland.pr_breakout.height dummy
scoreboard objectives add survisland.pr_breakout.invert dummy
scoreboard objectives add survisland.pr_breakout.death_v dummy
scoreboard objectives add survisland.pr_breakout.bumper_top dummy
scoreboard objectives add survisland.pr_breakout.remaining dummy
team add survisland.breakout.white
team modify survisland.breakout.white color white
team modify survisland.breakout.white collisionRule never
team add survisland.breakout.orange
team modify survisland.breakout.orange color gold
team modify survisland.breakout.orange collisionRule never
team add survisland.breakout.magenta
team modify survisland.breakout.magenta color light_purple
team modify survisland.breakout.magenta collisionRule never
team add survisland.breakout.light_blue
team modify survisland.breakout.light_blue color aqua
team modify survisland.breakout.light_blue collisionRule never
team add survisland.breakout.yellow
team modify survisland.breakout.yellow color yellow
team modify survisland.breakout.yellow collisionRule never
team add survisland.breakout.lime
team modify survisland.breakout.lime color green
team modify survisland.breakout.lime collisionRule never
team add survisland.breakout.pink
team modify survisland.breakout.pink color light_purple
team modify survisland.breakout.pink collisionRule never
team add survisland.breakout.gray
team modify survisland.breakout.gray color dark_gray
team modify survisland.breakout.gray collisionRule never
team add survisland.breakout.light_gray
team modify survisland.breakout.light_gray color gray
team modify survisland.breakout.light_gray collisionRule never
team add survisland.breakout.cyan
team modify survisland.breakout.cyan color dark_aqua
team modify survisland.breakout.cyan collisionRule never
team add survisland.breakout.purple
team modify survisland.breakout.purple color dark_purple
team modify survisland.breakout.purple collisionRule never
team add survisland.breakout.blue
team modify survisland.breakout.blue color blue
team modify survisland.breakout.blue collisionRule never
team add survisland.breakout.brown
team modify survisland.breakout.brown color gold
team modify survisland.breakout.brown collisionRule never
team add survisland.breakout.green
team modify survisland.breakout.green color dark_green
team modify survisland.breakout.green collisionRule never
team add survisland.breakout.red
team modify survisland.breakout.red color red
team modify survisland.breakout.red collisionRule never
team add survisland.breakout.black
team modify survisland.breakout.black color black
team modify survisland.breakout.black collisionRule never
execute as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,distance=..16] run function survisland:modes/pr_stoupy/breakout/forget_arena

scoreboard players add #pr_breakout_arena_counter survisland.data 1
scoreboard players operation #pr_breakout_arena survisland.data = #pr_breakout_arena_counter survisland.data
scoreboard players set #pr_breakout_state survisland.data 0
scoreboard players set #pr_breakout_level survisland.data 0
$scoreboard players set #pr_breakout_width survisland.data $(width)
$scoreboard players set #pr_breakout_height survisland.data $(height)
$scoreboard players set #pr_breakout_invert survisland.data $(invert)
$data modify storage survisland:pr_breakout axis set value "$(axis)"
scoreboard players set #pr_breakout_axis survisland.data 0
execute if data storage survisland:pr_breakout {axis:"z"} run scoreboard players set #pr_breakout_axis survisland.data 1
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function survisland:modes/pr_stoupy/breakout/setup_corner
tellraw @a[distance=..16] {"text":"Casse-briques : terrain configuré.","color":"green"}

