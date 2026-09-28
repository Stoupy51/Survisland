
#> survisland:modes/pr_stoupy/orbit/here/set_hole
#
# @within	???
#

# The hole anchors the arena of the room and pushes along the yaw of the caller, a hole placed again near the previous one keeps its arena
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
tellraw @a[distance=..16] {"text":"Orbite : ancre placée (arrivée des joueurs, poussée vers son yaw), place ensuite orbit et collector.","color":"green"}

