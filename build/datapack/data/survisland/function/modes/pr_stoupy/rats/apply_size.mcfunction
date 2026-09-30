
#> survisland:modes/pr_stoupy/rats/apply_size
#
# @executed	as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new]
#
# @within	survisland:modes/pr_stoupy/rats/resize
#			survisland:modes/pr_stoupy/rats/restore
#

# Hitbox and model scaled together from the size of @s
scoreboard players operation #pr_rats_hitbox survisland.data = @s survisland.pr_rats.size
execute store result storage survisland:pr_rats size.hitbox double 0.001 run scoreboard players operation #pr_rats_hitbox survisland.data *= #6 survisland.data
function survisland:modes/pr_stoupy/rats/apply_hitbox with storage survisland:pr_rats size
scoreboard players operation #pr_rats_model survisland.data = @s survisland.pr_rats.size
scoreboard players operation #pr_rats_model survisland.data *= #5 survisland.data
scoreboard players operation #pr_rats_offset survisland.data = @s survisland.pr_rats.size
scoreboard players operation #pr_rats_offset survisland.data *= #-17 survisland.data
execute on passengers run function survisland:modes/pr_stoupy/rats/resize_model

