
#> survisland:modes/pr_stoupy/breakout/new_ball
#
# @executed	at @s & positioned ^ ^2 ^0.5
#
# @within	survisland:modes/pr_stoupy/breakout/spawn_ball [ at @s & positioned ^ ^2 ^0.5 ]
#			survisland:modes/pr_stoupy/breakout/bonus/split [ at @s ]
#			survisland:modes/pr_stoupy/breakout/bonus/new_clone
#

data merge entity @s {Tags:["survisland.pr_breakout.ball"],Size:0,Invulnerable:1b,Silent:1b,PersistenceRequired:1b,equipment:{body:{id:"minecraft:stone",count:1}},drop_chances:{body:0.0f},attributes:[{id:"minecraft:gravity",base:0.0d},{id:"minecraft:bounciness",base:1.0d},{id:"minecraft:air_drag_modifier",base:0.0d},{id:"minecraft:friction_modifier",base:0.0d},{id:"minecraft:scale",base:0.8d},{id:"minecraft:movement_speed",base:0.0d}]}
scoreboard players operation @s survisland.pr_breakout = #pr_breakout_slot survisland.data
scoreboard players operation @s survisland.pr_breakout.arena = #pr_breakout_arena survisland.data
scoreboard players operation @s survisland.pr_breakout.color = #pr_breakout_color survisland.data
execute if score #pr_breakout_color survisland.data matches 0 run data modify entity @s equipment.body.id set value "minecraft:white_concrete"
execute if score #pr_breakout_color survisland.data matches 1 run data modify entity @s equipment.body.id set value "minecraft:orange_concrete"
execute if score #pr_breakout_color survisland.data matches 2 run data modify entity @s equipment.body.id set value "minecraft:magenta_concrete"
execute if score #pr_breakout_color survisland.data matches 3 run data modify entity @s equipment.body.id set value "minecraft:light_blue_concrete"
execute if score #pr_breakout_color survisland.data matches 4 run data modify entity @s equipment.body.id set value "minecraft:yellow_concrete"
execute if score #pr_breakout_color survisland.data matches 5 run data modify entity @s equipment.body.id set value "minecraft:lime_concrete"
execute if score #pr_breakout_color survisland.data matches 6 run data modify entity @s equipment.body.id set value "minecraft:pink_concrete"
execute if score #pr_breakout_color survisland.data matches 7 run data modify entity @s equipment.body.id set value "minecraft:gray_concrete"
execute if score #pr_breakout_color survisland.data matches 8 run data modify entity @s equipment.body.id set value "minecraft:light_gray_concrete"
execute if score #pr_breakout_color survisland.data matches 9 run data modify entity @s equipment.body.id set value "minecraft:cyan_concrete"
execute if score #pr_breakout_color survisland.data matches 10 run data modify entity @s equipment.body.id set value "minecraft:purple_concrete"
execute if score #pr_breakout_color survisland.data matches 11 run data modify entity @s equipment.body.id set value "minecraft:blue_concrete"
execute if score #pr_breakout_color survisland.data matches 12 run data modify entity @s equipment.body.id set value "minecraft:brown_concrete"
execute if score #pr_breakout_color survisland.data matches 13 run data modify entity @s equipment.body.id set value "minecraft:green_concrete"
execute if score #pr_breakout_color survisland.data matches 14 run data modify entity @s equipment.body.id set value "minecraft:red_concrete"
execute if score #pr_breakout_color survisland.data matches 15 run data modify entity @s equipment.body.id set value "minecraft:black_concrete"
team join survisland.no_collision @s
scoreboard players operation @s survisland.pr_breakout.speed = #pr_breakout_speed survisland.data

# Launched upward along one of the middle slices, left or right at random
execute store result score #pr_breakout_zone survisland.data run random value 2..5
function survisland:modes/pr_stoupy/breakout/apply_zone
scoreboard players operation @s survisland.pr_breakout.mu = #pr_breakout_mu survisland.data
scoreboard players operation @s survisland.pr_breakout.mv = #pr_breakout_mv survisland.data

