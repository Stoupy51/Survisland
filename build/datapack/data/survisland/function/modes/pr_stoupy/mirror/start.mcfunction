
#> survisland:modes/pr_stoupy/mirror/start
#
# @within	???
#
# @args		axis (unknown)
#			tp (unknown)
#

# Safe to fire every tick: one session per command block, and only with two free players on the start pads
tag @a[tag=survisland.pr_stoupy.back,predicate=!survisland:modes/pr_stoupy/on_start_pad] remove survisland.pr_stoupy.back
execute if entity @e[type=minecraft:marker,tag=survisland.pr_mirror.anchor,distance=..1] run return 0
execute store result score #pr_mirror_free survisland.data if entity @a[tag=!survisland.pr_mirror,tag=!survisland.pr_stoupy.back,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,gamemode=!spectator]
execute unless score #pr_mirror_free survisland.data matches 1.. run return 0
execute unless score #pr_stoupy_solo survisland.data matches 1 unless score #pr_mirror_free survisland.data matches 2.. run return 0
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
scoreboard objectives add survisland.pr_mirror.sneak dummy

# The mirror plane goes through this block, normal to the given axis
$data modify storage survisland:pr_mirror axis set value "$(axis)"
scoreboard players set #pr_mirror_flip_x survisland.data 1
scoreboard players set #pr_mirror_flip_z survisland.data 1
execute if data storage survisland:pr_mirror {axis:"x"} run scoreboard players set #pr_mirror_flip_x survisland.data -1
execute if data storage survisland:pr_mirror {axis:"z"} run scoreboard players set #pr_mirror_flip_z survisland.data -1
scoreboard players add #pr_mirror_session_counter survisland.data 1
scoreboard players operation #pr_mirror_session survisland.data = #pr_mirror_session_counter survisland.data
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function survisland:modes/pr_stoupy/mirror/new_anchor

# $(tp) moves each player from where it stands, "" to leave them on the pads
scoreboard players set #pr_mirror_slot_counter survisland.data 0
tag @a[tag=!survisland.pr_mirror,tag=!survisland.pr_stoupy.back,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,gamemode=!spectator,limit=2,sort=nearest] add survisland.pr_mirror.entering
$data modify storage survisland:pr_stoupy tp set value "$(tp)"
execute as @a[tag=survisland.pr_mirror.entering] at @s run function survisland:modes/pr_stoupy/teleport
execute as @a[tag=survisland.pr_mirror.entering] at @s run function survisland:modes/pr_stoupy/mirror/enroll_player
tag @a remove survisland.pr_mirror.entering
schedule function survisland:modes/pr_stoupy/mirror/tick 1t replace

