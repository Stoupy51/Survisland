
#> survisland:modes/pr_stoupy/mirror/start
#
# @within	???
#
# @args		axis (unknown)
#

# Safe to fire every tick: one session per command block, and only with two free players standing here
execute if entity @e[type=minecraft:marker,tag=survisland.pr_mirror.anchor,distance=..1] run return 0
execute store result score #pr_mirror_free survisland.data if entity @a[tag=!survisland.pr_mirror,distance=..3,gamemode=!creative,gamemode=!spectator]
execute if score #pr_mirror_free survisland.data matches ..1 run return 0
scoreboard objectives add survisland.pr_mirror dummy
scoreboard objectives add survisland.pr_mirror.session dummy
scoreboard objectives add survisland.pr_mirror.x dummy
scoreboard objectives add survisland.pr_mirror.y dummy
scoreboard objectives add survisland.pr_mirror.z dummy
scoreboard objectives add survisland.pr_mirror.plane_x dummy
scoreboard objectives add survisland.pr_mirror.plane_z dummy
scoreboard objectives add survisland.pr_mirror.flip_x dummy
scoreboard objectives add survisland.pr_mirror.flip_z dummy
scoreboard objectives add survisland.pr_mirror.frozen dummy
scoreboard objectives add survisland.pr_mirror.moving dummy
scoreboard objectives add survisland.pr_mirror.yaw dummy
scoreboard objectives add survisland.pr_mirror.pitch dummy

# The mirror plane goes through this block, normal to the given axis
$data modify storage survisland:pr_mirror axis set value "$(axis)"
scoreboard players set #pr_mirror_flip_x survisland.data 1
scoreboard players set #pr_mirror_flip_z survisland.data 1
execute if data storage survisland:pr_mirror {axis:"x"} run scoreboard players set #pr_mirror_flip_x survisland.data -1
execute if data storage survisland:pr_mirror {axis:"z"} run scoreboard players set #pr_mirror_flip_z survisland.data -1
scoreboard players add #pr_mirror_session_counter survisland.data 1
scoreboard players operation #pr_mirror_session survisland.data = #pr_mirror_session_counter survisland.data
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function survisland:modes/pr_stoupy/mirror/new_anchor

scoreboard players set #pr_mirror_slot_counter survisland.data 0
execute as @a[tag=!survisland.pr_mirror,distance=..3,gamemode=!creative,gamemode=!spectator,limit=2,sort=nearest] at @s run function survisland:modes/pr_stoupy/mirror/enroll_player
schedule function survisland:modes/pr_stoupy/mirror/tick 1t replace

