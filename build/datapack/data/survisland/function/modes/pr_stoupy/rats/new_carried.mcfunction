
#> survisland:modes/pr_stoupy/rats/new_carried
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/rats/catch [ at @s ]
#

tag @s add survisland.pr_rats.carried
data modify entity @s item set from storage survisland:pr_rats model.item
data modify entity @s transformation set from storage survisland:pr_rats model.transformation
data modify entity @s transformation.translation set value [0.0f,0.0f,0.0f]
data modify entity @s Glowing set from storage survisland:pr_rats model.Glowing
data modify entity @s glow_color_override set from storage survisland:pr_rats model.glow_color_override
data modify entity @s teleport_duration set value 1
scoreboard players operation @s survisland.pr_rats.id = #pr_rats_id survisland.data
scoreboard players operation @s survisland.pr_rats.index = #pr_rats_index survisland.data
scoreboard players operation @s survisland.pr_rats.arena = #pr_rats_arena survisland.data

