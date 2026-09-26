
#> survisland:modes/pr_stoupy/rats/resize_model
#
# @executed	as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new]
#
# @within	survisland:modes/pr_stoupy/rats/resize
#

execute store result entity @s transformation.scale[0] float 0.001 run scoreboard players get #pr_rats_model survisland.data
execute store result entity @s transformation.scale[1] float 0.001 run scoreboard players get #pr_rats_model survisland.data
execute store result entity @s transformation.scale[2] float 0.001 run scoreboard players get #pr_rats_model survisland.data
execute store result entity @s transformation.translation[1] float 0.0001 run scoreboard players get #pr_rats_offset survisland.data

