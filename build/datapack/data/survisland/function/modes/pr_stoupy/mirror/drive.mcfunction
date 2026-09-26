
#> survisland:modes/pr_stoupy/mirror/drive
#
# @executed	as @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_pair]
#
# @within	survisland:modes/pr_stoupy/mirror/player_tick [ as @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_pair] ]
#

execute if score @s survisland.pr_mirror.frozen matches 1 run return 0

# A rise starting from the ground is a jump, gravity handles the rest of the arc
execute if score #pr_mirror_dy survisland.data matches 100.. if predicate survisland:on_ground run data modify entity @s Motion[1] set value 0.42d

# Turn only when the aim changed
execute unless score #pr_mirror_yaw survisland.data = @s survisland.pr_mirror.yaw run function survisland:modes/pr_stoupy/mirror/aim
execute unless score #pr_mirror_pitch survisland.data = @s survisland.pr_mirror.pitch run function survisland:modes/pr_stoupy/mirror/aim

# Writing Motion costs a full entity save, so a still player writes its stop once and then nothing
scoreboard players set #pr_mirror_moving survisland.data 0
execute unless score #pr_mirror_dx survisland.data matches 0 run scoreboard players set #pr_mirror_moving survisland.data 1
execute unless score #pr_mirror_dz survisland.data matches 0 run scoreboard players set #pr_mirror_moving survisland.data 1
execute if score #pr_mirror_moving survisland.data matches 0 if score @s survisland.pr_mirror.moving matches 0 run return 0
scoreboard players operation @s survisland.pr_mirror.moving = #pr_mirror_moving survisland.data
execute store result entity @s Motion[0] double 0.001 run scoreboard players get #pr_mirror_dx survisland.data
execute store result entity @s Motion[2] double 0.001 run scoreboard players get #pr_mirror_dz survisland.data

