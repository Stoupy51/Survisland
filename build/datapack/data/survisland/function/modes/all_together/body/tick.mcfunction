
#> survisland:modes/all_together/body/tick
#
# @executed	at @s
#
# @within	survisland:modes/all_together/tick [ at @s ]
#

scoreboard players add #all_together_alive survisland.data 1
scoreboard players operation #all_together_group survisland.data = @s survisland.all_together.group

# The mouse holder aims the mannequin, and the mannequin aims everyone else
execute on passengers if entity @s[tag=survisland.all_together.look] rotated as @s on vehicle run function survisland:modes/all_together/body/aim

# Forget the inputs of the previous tick, then let every rider report the keys it holds down
scoreboard players set #all_together_in_forward survisland.data 0
scoreboard players set #all_together_in_backward survisland.data 0
scoreboard players set #all_together_in_left survisland.data 0
scoreboard players set #all_together_in_right survisland.data 0
scoreboard players set #all_together_in_jump survisland.data 0
scoreboard players set #all_together_in_sneak survisland.data 0
scoreboard players set #all_together_in_sprint survisland.data 0
scoreboard players set #all_together_in_crawl survisland.data 0
scoreboard players set #all_together_crew survisland.data 0
execute on passengers run function survisland:modes/all_together/body/read_player
execute rotated as @s anchored eyes positioned ^ ^ ^0.6 as @e[type=item_display,tag=survisland.all_together.seat,distance=..3] if score @s survisland.all_together.group = #all_together_group survisland.data run function survisland:modes/all_together/body/seat_tick

# Vanilla reads shift as a dismount, so whoever fell off is put back on and read right away
execute unless score #all_together_crew survisland.data matches 4 run function survisland:modes/all_together/body/remount

# Only the mouse holder keeps its own aim, the others look through the same eyes
execute rotated as @s on passengers unless entity @s[tag=survisland.all_together.look] run function survisland:modes/all_together/body/aim

# Pose: 0 standing, 1 crouching, 2 lying down
scoreboard players set #all_together_pose survisland.data 0
execute if score #all_together_in_sneak survisland.data matches 1.. run scoreboard players set #all_together_pose survisland.data 1
execute if score #all_together_in_crawl survisland.data matches 1.. run scoreboard players set #all_together_pose survisland.data 2
execute unless score #all_together_pose survisland.data = @s survisland.all_together.pose run function survisland:modes/all_together/body/update_pose

# Speed of this tick, walking unless the group crouches or sprints
scoreboard players operation #all_together_speed survisland.data = #all_together_speed_walk survisland.data
execute if score #all_together_pose survisland.data matches 1.. run scoreboard players operation #all_together_speed survisland.data = #all_together_speed_sneak survisland.data

# A held sprint key flips on every keyboard repeat with Toggle Sprint on, so the press is latched for SPRINT_HOLD ticks
execute if score @s survisland.all_together.sprint matches 1.. run scoreboard players remove @s survisland.all_together.sprint 1
execute if score #all_together_in_sprint survisland.data matches 1.. run scoreboard players set @s survisland.all_together.sprint 5
execute if score #all_together_pose survisland.data matches 0 if score @s survisland.all_together.sprint matches 1.. run scoreboard players operation #all_together_speed survisland.data = #all_together_speed_sprint survisland.data

# Local velocity, in thousandths of a block per tick (+x is left, +z is forward)
scoreboard players set @s bs.vel.x 0
scoreboard players set @s bs.vel.y 0
scoreboard players set @s bs.vel.z 0
execute if score #all_together_in_forward survisland.data matches 1.. if score #all_together_in_backward survisland.data matches 0 run scoreboard players operation @s bs.vel.z = #all_together_speed survisland.data
execute if score #all_together_in_backward survisland.data matches 1.. if score #all_together_in_forward survisland.data matches 0 run scoreboard players operation @s bs.vel.z -= #all_together_speed_back survisland.data
execute if score #all_together_in_left survisland.data matches 1.. if score #all_together_in_right survisland.data matches 0 run scoreboard players operation @s bs.vel.x = #all_together_speed survisland.data
execute if score #all_together_in_right survisland.data matches 1.. if score #all_together_in_left survisland.data matches 0 run scoreboard players operation @s bs.vel.x -= #all_together_speed survisland.data
execute if score #all_together_in_jump survisland.data matches 1.. if predicate survisland:on_ground run scoreboard players set @s bs.vel.y 420

# Gravity owns the vertical motion, so it is only written on the tick the group jumps
execute if score @s bs.vel.y matches 1.. store result entity @s Motion[1] double 0.001 run scoreboard players get @s bs.vel.y

# Writing Motion costs a full entity save, so a group standing still writes its stop once and then nothing
scoreboard players set #all_together_moving survisland.data 0
execute unless score @s bs.vel.x matches 0 run scoreboard players set #all_together_moving survisland.data 1
execute unless score @s bs.vel.z matches 0 run scoreboard players set #all_together_moving survisland.data 1
execute if score #all_together_moving survisland.data matches 0 if score @s survisland.all_together.moving matches 0 run return 0
scoreboard players operation @s survisland.all_together.moving = #all_together_moving survisland.data

# Hand the velocity over to the vanilla physics (collisions, step up, gravity and fall are free)
execute if score #all_together_moving survisland.data matches 1 rotated as @s rotated ~ 0 run function #bs.move:local_to_canonical
execute store result entity @s Motion[0] double 0.001 run scoreboard players get @s bs.vel.x
execute store result entity @s Motion[2] double 0.001 run scoreboard players get @s bs.vel.z

