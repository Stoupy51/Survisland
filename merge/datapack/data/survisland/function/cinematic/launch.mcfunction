
## /execute as @s positioned 0 69 0 rotated -55 10 run function switch:cinematic/launch {x:19.5,y:82.5,z:23.5,time:60,with:{yaw:30,pitch:-15,go_side:1,add_y:20.0,particle:1,interpolation:1}}
# Arguments:
# as @s = player
# at @s = current position
# x: float = target x position
# y: float = target y position
# z: float = target z position
# time: int = time in ticks
# with: {...} = additional arguments (optional)
#   yaw: float = yaw rotation
#   pitch: float = pitch rotation
#   go_side: float = how far to go side (0 = don't go side)
#   add_y: float = additional y position (to add to the middle point, if none default is 20.0)
#   particle: int = particle effect (0 = none, 1 = glow)
#   interpolation: int = teleport_duration (0 = instant, 1 = 1 tick, 2 = 2 ticks, etc.)

# Tag the player and remember it's id
scoreboard players operation #player_id survisland.id = @s survisland.id
tag @s add survisland.temp

## Get the arguments
# Get the target position as double type (and increment height by 1.6)
$data modify storage switch:temp temp set value [$(x),$(y),$(z)]
data modify storage switch:temp target_position set value [0.0d, 0.0d, 0.0d]
execute store result storage switch:temp target_position[0] double 0.001 run data get storage switch:temp temp[0] 1000
execute store result score #temp survisland.data run data get storage switch:temp temp[1] 1000
scoreboard players add #temp survisland.data 1600
execute store result storage switch:temp target_position[1] double 0.001 run scoreboard players get #temp survisland.data
execute store result storage switch:temp target_position[2] double 0.001 run data get storage switch:temp temp[2] 1000

# Get the time as int type
$scoreboard players set #cinematic_time survisland.data $(time)

# Get the current position (y + 1.6) and rotation
tp @s ~ ~1.6 ~ ~ ~
data modify storage switch:temp current_position set from entity @s Pos
data modify storage switch:temp current_rotation set from entity @s Rotation
data modify storage switch:temp target_rotation set from storage switch:temp current_rotation


## Remember the additional arguments
$data modify storage switch:temp with set value $(with)
execute unless data storage switch:temp with.interpolation run data modify storage switch:temp with.interpolation set value 1
execute store result score #cinematic_interpolation survisland.data run data get storage switch:temp with.interpolation
execute if data storage switch:temp with.pitch if data storage switch:temp with.yaw run function switch:cinematic/get_rotation_arguments with storage switch:temp with
execute unless data storage switch:temp with.go_side run data modify storage switch:temp with.go_side set value 0
execute unless data storage switch:temp with.add_y run data modify storage switch:temp with.add_y set value 20.0


## Summon the entity that will control the player
execute summon item_display run function switch:cinematic/setup_entity

# Remove the tag
tag @s remove survisland.temp

