
#> survisland:modes/pr_stoupy/rats/summon/mutant
#
# @within	survisland:modes/pr_stoupy/rats/here/place_rat
#			survisland:modes/pr_stoupy/rats/spawn_loop
#			survisland:modes/pr_stoupy/rats/release_one
#

# The new rat keeps the survisland.pr_rats.new tag until the caller resizes it
scoreboard objectives add survisland.pr_rats.carried dummy
scoreboard objectives add survisland.pr_rats.id dummy
scoreboard objectives add survisland.pr_rats.index dummy
scoreboard objectives add survisland.pr_rats.arena dummy
scoreboard objectives add survisland.pr_rats.size dummy
scoreboard objectives add survisland.pr_rats.variant dummy
summon minecraft:ocelot ~ ~ ~ {Tags:["survisland.pr_rats.rat","survisland.pr_rats.new"],PersistenceRequired:1b,Silent:1b,Trusting:0b,Age:0,active_effects:[{id:"minecraft:invisibility",duration:-1,amplifier:0b,show_particles:0b},{id:"minecraft:resistance",duration:-1,amplifier:4b,show_particles:0b}],attributes:[{id:"minecraft:movement_speed",base:0.42d}],Passengers:[{id:"minecraft:item_display",Tags:["survisland.pr_rats.model"],item_display:"none",teleport_duration:1,item:{id:"minecraft:stone",count:1,components:{"minecraft:item_model":"survisland:rat_mutant"}}}]}
scoreboard players set @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] survisland.pr_rats.variant 3
schedule function survisland:modes/pr_stoupy/rats/tick 1t replace

