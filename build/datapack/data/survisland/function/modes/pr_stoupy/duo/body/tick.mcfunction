
#> survisland:modes/pr_stoupy/duo/body/tick
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/tick [ at @s ]
#

scoreboard players add #pr_stoupy_duo_alive survisland.data 1
scoreboard players operation #pr_stoupy_duo_group survisland.data = @s survisland.pr_stoupy_duo.group

# The mouse holder aims the mannequin, and the mannequin aims everyone else
execute on passengers if entity @s[tag=survisland.pr_stoupy_duo.look] rotated as @s on vehicle run function survisland:modes/pr_stoupy/duo/body/aim

# Forget the inputs of the previous tick, then let every rider report the keys it holds down
scoreboard players set #pr_stoupy_duo_in_forward survisland.data 0
scoreboard players set #pr_stoupy_duo_in_backward survisland.data 0
scoreboard players set #pr_stoupy_duo_in_left survisland.data 0
scoreboard players set #pr_stoupy_duo_in_right survisland.data 0
scoreboard players set #pr_stoupy_duo_in_jump survisland.data 0
scoreboard players set #pr_stoupy_duo_in_sneak survisland.data 0
scoreboard players set #pr_stoupy_duo_in_sprint survisland.data 0
scoreboard players set #pr_stoupy_duo_in_crawl survisland.data 0
scoreboard players set #pr_stoupy_duo_crew survisland.data 0
execute on passengers run function survisland:modes/pr_stoupy/duo/body/read_player
execute store success score #pr_stoupy_duo_seat survisland.data rotated as @s anchored eyes positioned ^ ^ ^0.6 as @e[type=item_display,tag=survisland.pr_stoupy_duo.seat,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] run function survisland:modes/pr_stoupy/duo/body/seat_tick
execute if score #pr_stoupy_duo_seat survisland.data matches 0 run function survisland:modes/pr_stoupy/duo/body/find_seat

# Vanilla reads shift as a dismount, so whoever fell off is put back on and read right away
execute unless score #pr_stoupy_duo_crew survisland.data matches 2 run function survisland:modes/pr_stoupy/duo/body/remount

# Only the mouse holder keeps its own aim, the others look through the same eyes
execute rotated as @s on passengers unless entity @s[tag=survisland.pr_stoupy_duo.look] run function survisland:modes/pr_stoupy/duo/body/aim

# Pose: 0 standing, 1 crouching, 2 lying down
scoreboard players set #pr_stoupy_duo_pose survisland.data 0
execute if score #pr_stoupy_duo_in_sneak survisland.data matches 1.. run scoreboard players set #pr_stoupy_duo_pose survisland.data 1
execute if score #pr_stoupy_duo_in_crawl survisland.data matches 1.. run scoreboard players set #pr_stoupy_duo_pose survisland.data 2
execute unless score #pr_stoupy_duo_pose survisland.data = @s survisland.pr_stoupy_duo.pose run function survisland:modes/pr_stoupy/duo/body/update_pose

# Speed of this tick, walking unless the group crouches or sprints
scoreboard players operation #pr_stoupy_duo_speed survisland.data = #pr_stoupy_duo_speed_walk survisland.data
execute if score #pr_stoupy_duo_pose survisland.data matches 1.. run scoreboard players operation #pr_stoupy_duo_speed survisland.data = #pr_stoupy_duo_speed_sneak survisland.data

# A held sprint key flips on every keyboard repeat with Toggle Sprint on, so the press is latched for SPRINT_HOLD ticks
execute if score @s survisland.pr_stoupy_duo.sprint matches 1.. run scoreboard players remove @s survisland.pr_stoupy_duo.sprint 1
execute if score #pr_stoupy_duo_in_sprint survisland.data matches 1.. run scoreboard players set @s survisland.pr_stoupy_duo.sprint 5
execute if score #pr_stoupy_duo_pose survisland.data matches 0 if score @s survisland.pr_stoupy_duo.sprint matches 1.. run scoreboard players operation #pr_stoupy_duo_speed survisland.data = #pr_stoupy_duo_speed_sprint survisland.data

# Local velocity, in thousandths of a block per tick (+x is left, +z is forward)
scoreboard players set @s bs.vel.x 0
scoreboard players set @s bs.vel.y 0
scoreboard players set @s bs.vel.z 0
execute if score #pr_stoupy_duo_in_forward survisland.data matches 1.. if score #pr_stoupy_duo_in_backward survisland.data matches 0 run scoreboard players operation @s bs.vel.z = #pr_stoupy_duo_speed survisland.data
execute if score #pr_stoupy_duo_in_backward survisland.data matches 1.. if score #pr_stoupy_duo_in_forward survisland.data matches 0 run scoreboard players operation @s bs.vel.z -= #pr_stoupy_duo_speed_back survisland.data
execute if score #pr_stoupy_duo_in_left survisland.data matches 1.. if score #pr_stoupy_duo_in_right survisland.data matches 0 run scoreboard players operation @s bs.vel.x = #pr_stoupy_duo_speed survisland.data
execute if score #pr_stoupy_duo_in_right survisland.data matches 1.. if score #pr_stoupy_duo_in_left survisland.data matches 0 run scoreboard players operation @s bs.vel.x -= #pr_stoupy_duo_speed survisland.data
execute if score #pr_stoupy_duo_in_jump survisland.data matches 1.. if predicate survisland:on_ground run scoreboard players set @s bs.vel.y 420

# Gravity owns the vertical motion, so it is only written on the tick the group jumps
execute if score @s bs.vel.y matches 1.. store result entity @s Motion[1] double 0.001 run scoreboard players get @s bs.vel.y

# Writing Motion costs a full entity save, so a group standing still writes its stop once and then nothing
scoreboard players set #pr_stoupy_duo_moving survisland.data 0
execute unless score @s bs.vel.x matches 0 run scoreboard players set #pr_stoupy_duo_moving survisland.data 1
execute unless score @s bs.vel.z matches 0 run scoreboard players set #pr_stoupy_duo_moving survisland.data 1
execute if score #pr_stoupy_duo_moving survisland.data matches 0 if score @s survisland.pr_stoupy_duo.moving matches 0 run return 0
scoreboard players operation @s survisland.pr_stoupy_duo.moving = #pr_stoupy_duo_moving survisland.data

# Hand the velocity over to the vanilla physics (collisions, step up, gravity and fall are free)
execute if score #pr_stoupy_duo_moving survisland.data matches 1 rotated as @s rotated ~ 0 run function #bs.move:local_to_canonical
execute store result entity @s Motion[0] double 0.001 run scoreboard players get @s bs.vel.x
execute store result entity @s Motion[2] double 0.001 run scoreboard players get @s bs.vel.z

