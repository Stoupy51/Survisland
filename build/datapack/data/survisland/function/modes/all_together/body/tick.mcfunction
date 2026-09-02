
#> survisland:modes/all_together/body/tick
#
# @executed	at @s
#
# @within	survisland:modes/all_together/tick [ at @s ]
#

execute as @a[tag=survisland.all_together.look] if score @s survisland.all_together.group = @n[type=mannequin,tag=survisland.all_together.body] survisland.all_together.group run function survisland:modes/all_together/body/look_tick

# Forget the inputs of the previous tick
scoreboard players set #all_together_in_forward survisland.data 0
scoreboard players set #all_together_in_backward survisland.data 0
scoreboard players set #all_together_in_left survisland.data 0
scoreboard players set #all_together_in_right survisland.data 0
scoreboard players set #all_together_in_jump survisland.data 0
scoreboard players set #all_together_in_sneak survisland.data 0
scoreboard players set #all_together_in_sprint survisland.data 0
scoreboard players set #all_together_in_crawl survisland.data 0
scoreboard players set #all_together_in_holders survisland.data 0

# Single scan of the group: every sensor reports its inputs and gets stuck on the mannequin eyes
execute as @a[tag=survisland.all_together] if score @s survisland.all_together.group = @n[type=mannequin,tag=survisland.all_together.body] survisland.all_together.group run function survisland:modes/all_together/body/read_player

# Pose: 0 standing, 1 crouching, 2 lying down
scoreboard players set #all_together_pose survisland.data 0
execute if score #all_together_in_sneak survisland.data matches 1.. run scoreboard players set #all_together_pose survisland.data 1
execute if score #all_together_in_crawl survisland.data matches 1.. run scoreboard players set #all_together_pose survisland.data 2
execute unless score #all_together_pose survisland.data = @s survisland.all_together.pose run function survisland:modes/all_together/body/update_pose

# Speed of this tick, depending on the pose and on how the part triggers sprinting
scoreboard players operation #all_together_speed survisland.data = #all_together_speed_walk survisland.data
execute if score #all_together_pose survisland.data matches 1.. run scoreboard players operation #all_together_speed survisland.data = #all_together_speed_sneak survisland.data
execute if score #all_together_pose survisland.data matches 0 if score @s survisland.all_together.sprint matches 0 if score #all_together_in_sprint survisland.data matches 1.. run scoreboard players operation #all_together_speed survisland.data = #all_together_speed_sprint survisland.data
execute if score #all_together_pose survisland.data matches 0 if score @s survisland.all_together.sprint matches 1 if score #all_together_in_holders survisland.data matches 1.. if score #all_together_in_forward survisland.data = #all_together_in_holders survisland.data run scoreboard players operation #all_together_speed survisland.data = #all_together_speed_sprint survisland.data

# Local velocity, in thousandths of a block per tick (+x is left, +z is forward)
scoreboard players set @s bs.vel.x 0
scoreboard players set @s bs.vel.z 0
execute store result score @s bs.vel.y run data get entity @s Motion[1] 1000
execute if score #all_together_in_forward survisland.data matches 1.. if score #all_together_in_backward survisland.data matches 0 run scoreboard players operation @s bs.vel.z = #all_together_speed survisland.data
execute if score #all_together_in_backward survisland.data matches 1.. if score #all_together_in_forward survisland.data matches 0 run scoreboard players operation @s bs.vel.z -= #all_together_speed_back survisland.data
execute if score #all_together_in_left survisland.data matches 1.. if score #all_together_in_right survisland.data matches 0 run scoreboard players operation @s bs.vel.x = #all_together_speed survisland.data
execute if score #all_together_in_right survisland.data matches 1.. if score #all_together_in_left survisland.data matches 0 run scoreboard players operation @s bs.vel.x -= #all_together_speed survisland.data
execute if score #all_together_in_jump survisland.data matches 1.. if entity @s[nbt={OnGround:1b}] run scoreboard players set @s bs.vel.y 420

# Hand the velocity over to the vanilla physics (collisions, step up, gravity and fall are free)
execute rotated ~ 0 run function #bs.move:local_to_canonical
function #bs.move:set_motion {scale:0.001}

