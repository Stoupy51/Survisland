
#> survisland:modes/pr_stoupy/rats/summon/mutant
#
# @within	survisland:modes/pr_stoupy/rats/spawn_loop
#

scoreboard objectives add survisland.pr_rats.carried dummy
scoreboard objectives add survisland.pr_rats.id dummy
scoreboard objectives add survisland.pr_rats.index dummy
scoreboard objectives add survisland.pr_rats.arena dummy
summon minecraft:ocelot ~ ~ ~ {Tags:["survisland.pr_rats.rat","survisland.pr_rats.new"],PersistenceRequired:1b,Silent:1b,Trusting:0b,Age:0,active_effects:[{id:"minecraft:invisibility",duration:-1,amplifier:0b,show_particles:0b},{id:"minecraft:resistance",duration:-1,amplifier:4b,show_particles:0b}],attributes:[{id:"minecraft:movement_speed",base:0.42d}],Passengers:[{id:"minecraft:item_display",Tags:["survisland.pr_rats.model"],item_display:"none",teleport_duration:1,item:{id:"minecraft:stone",count:1,components:{"minecraft:item_model":"survisland:rat_mutant"}},Glowing:1b,glow_color_override:8453920}]}
execute as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] run function survisland:modes/pr_stoupy/rats/resize
schedule function survisland:modes/pr_stoupy/rats/tick 1t replace

