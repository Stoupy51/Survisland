
#> survisland:modes/pr_stoupy/rats/catch
#
# @executed	as the player & at current position
#
# @within	survisland:modes/pr_stoupy/rats/hit
#

# @s is the catcher: the model of the rat is copied onto a display floating above its head, then the rat is gone
execute unless score @s survisland.pr_rats.id matches 1.. store result score @s survisland.pr_rats.id run scoreboard players add #pr_rats_id_counter survisland.data 1
scoreboard players add @s survisland.pr_rats.carried 1
scoreboard players operation #pr_rats_id survisland.data = @s survisland.pr_rats.id
scoreboard players operation #pr_rats_index survisland.data = @s survisland.pr_rats.carried
execute as @n[type=minecraft:ocelot,tag=survisland.pr_rats.caught] on passengers run data modify storage survisland:pr_rats model set from entity @s
execute at @s summon minecraft:item_display run function survisland:modes/pr_stoupy/rats/new_carried
execute as @n[type=minecraft:ocelot,tag=survisland.pr_rats.caught] run function survisland:modes/pr_stoupy/rats/remove_rat
playsound minecraft:entity.rabbit.hurt neutral @a[distance=..16] ~ ~ ~ 1 1.6
title @s actionbar [{"text":"Rats portés : ","color":"gray"},{"score":{"name":"@s","objective":"survisland.pr_rats.carried"},"color":"aqua"},{"text":"/3","color":"aqua"}]

