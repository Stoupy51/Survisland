
#> survisland:modes/pr_stoupy/rats/resize
#
# @executed	as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new]
#
# @within	survisland:modes/pr_stoupy/rats/summon/grey [ as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] ]
#			survisland:modes/pr_stoupy/rats/summon/white [ as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] ]
#			survisland:modes/pr_stoupy/rats/summon/brown [ as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] ]
#			survisland:modes/pr_stoupy/rats/summon/mutant [ as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] ]
#

tag @s remove survisland.pr_rats.new
scoreboard players operation @s survisland.pr_rats.arena = @n[type=minecraft:marker,tag=survisland.pr_rats.cage] survisland.pr_rats.arena

# Hitbox and model scaled together, from 75..125 %
execute store result score #pr_rats_size survisland.data run random value 75..125
scoreboard players operation #pr_rats_hitbox survisland.data = #pr_rats_size survisland.data
execute store result storage survisland:pr_rats size.hitbox double 0.001 run scoreboard players operation #pr_rats_hitbox survisland.data *= #6 survisland.data
function survisland:modes/pr_stoupy/rats/apply_hitbox with storage survisland:pr_rats size
scoreboard players operation #pr_rats_model survisland.data = #pr_rats_size survisland.data
scoreboard players operation #pr_rats_model survisland.data *= #5 survisland.data
scoreboard players operation #pr_rats_offset survisland.data = #pr_rats_size survisland.data
scoreboard players operation #pr_rats_offset survisland.data *= #-17 survisland.data
execute on passengers run function survisland:modes/pr_stoupy/rats/resize_model

