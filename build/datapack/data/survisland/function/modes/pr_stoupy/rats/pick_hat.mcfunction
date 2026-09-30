
#> survisland:modes/pr_stoupy/rats/pick_hat
#
# @executed	as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new]
#
# @within	survisland:modes/pr_stoupy/rats/resize
#

execute if score #pr_rats_hat survisland.data matches 0 run data modify entity @s item.components."minecraft:custom_model_data" set value {strings:["top_hat"]}
execute if score #pr_rats_hat survisland.data matches 1 run data modify entity @s item.components."minecraft:custom_model_data" set value {strings:["party_hat"]}
execute if score #pr_rats_hat survisland.data matches 2 run data modify entity @s item.components."minecraft:custom_model_data" set value {strings:["crown"]}
execute if score #pr_rats_hat survisland.data matches 3 run data modify entity @s item.components."minecraft:custom_model_data" set value {strings:["chef_hat"]}
execute if score #pr_rats_hat survisland.data matches 4 run data modify entity @s item.components."minecraft:custom_model_data" set value {strings:["wizard_hat"]}

