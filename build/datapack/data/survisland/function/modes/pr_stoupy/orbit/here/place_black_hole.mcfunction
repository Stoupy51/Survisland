
#> survisland:modes/pr_stoupy/orbit/here/place_black_hole
#
# @within	???
#
# @args		scale (unknown)
#

# A huge inverted cube rendered by the black hole shader, seen from inside
kill @e[type=minecraft:item_display,tag=survisland.pr_orbit.sky,distance=..8]
$summon minecraft:item_display ~ ~ ~ {Tags:["survisland.pr_orbit.sky"],item:{id:"minecraft:stone",count:1,components:{"minecraft:item_model":"survisland:black_hole"}},view_range:10f,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[-$(scale)f,-$(scale)f,-$(scale)f]}}

# Its marker anchors the arena of the room and pushes along the yaw of the caller, a hole placed again near the previous one keeps its arena
scoreboard objectives add survisland.pr_orbit.carried dummy
scoreboard objectives add survisland.pr_orbit.arena dummy
scoreboard objectives add survisland.pr_orbit.state dummy
scoreboard objectives add survisland.pr_orbit.round dummy
scoreboard objectives add survisland.pr_orbit.banked dummy
scoreboard objectives add survisland.pr_orbit.required dummy
scoreboard objectives add survisland.pr_orbit.pull dummy
scoreboard objectives add survisland.pr_orbit.timer dummy
scoreboard objectives add survisland.pr_orbit.clock dummy
scoreboard players set #pr_orbit_arena survisland.data 0
execute as @n[type=minecraft:marker,tag=survisland.pr_orbit.hole,distance=..16] run scoreboard players operation #pr_orbit_arena survisland.data = @s survisland.pr_orbit.arena
kill @n[type=minecraft:marker,tag=survisland.pr_orbit.hole,distance=..16]
execute if score #pr_orbit_arena survisland.data matches 0 store result score #pr_orbit_arena survisland.data run scoreboard players add #pr_orbit_arena_counter survisland.data 1
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function survisland:modes/pr_stoupy/orbit/new_hole
tellraw @a[distance=..16] {"text":"Orbite : trou noir placé (arrivée des joueurs, poussée vers son yaw), place ensuite le collector.","color":"green"}

