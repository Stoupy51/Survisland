
#> survisland:modes/pr_stoupy/rats/spawn_loop
#
# @within	survisland:modes/pr_stoupy/rats/here/spawn_rats
#			survisland:modes/pr_stoupy/rats/spawn_loop
#

execute store result score #pr_rats_variant survisland.data run random value 0..3
execute if score #pr_rats_variant survisland.data matches 0 run function survisland:modes/pr_stoupy/rats/summon/grey
execute if score #pr_rats_variant survisland.data matches 1 run function survisland:modes/pr_stoupy/rats/summon/white
execute if score #pr_rats_variant survisland.data matches 2 run function survisland:modes/pr_stoupy/rats/summon/brown
execute if score #pr_rats_variant survisland.data matches 3 run function survisland:modes/pr_stoupy/rats/summon/mutant
tag @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat,distance=..0.1] add survisland.pr_rats.spreading
scoreboard players remove #pr_rats_to_spawn survisland.data 1
execute if score #pr_rats_to_spawn survisland.data matches 1.. run function survisland:modes/pr_stoupy/rats/spawn_loop

