
#> survisland:modes/pr_stoupy/duo/body/new
#
# @executed	at @a[tag=survisland.pr_stoupy_duo.new,scores={survisland.pr_stoupy_duo=1},limit=1]
#
# @within	survisland:modes/pr_stoupy/duo/body/form_group [ at @a[tag=survisland.pr_stoupy_duo.new,scores={survisland.pr_stoupy_duo=1},limit=1] ]
#

# Identity and state of this body
tag @s add survisland.pr_stoupy_duo.body
data merge entity @s {immovable:0b,hide_description:1b,Invulnerable:1b}
attribute @s minecraft:camera_distance base set 7
execute as @a[tag=survisland.pr_stoupy_duo.new,scores={survisland.pr_stoupy_duo=1},limit=1] run loot replace entity @n[type=mannequin,tag=survisland.pr_stoupy_duo.body,distance=..1] weapon.mainhand loot survisland:player_head
data modify entity @s profile set from entity @s equipment.mainhand.components."minecraft:profile"
item replace entity @s weapon.mainhand with minecraft:air
scoreboard players operation @s survisland.pr_stoupy_duo.group = #pr_stoupy_duo_group_counter survisland.data
scoreboard players operation #pr_stoupy_duo_group survisland.data = @s survisland.pr_stoupy_duo.group
scoreboard players set @s survisland.pr_stoupy_duo.phase 0
scoreboard players set @s survisland.pr_stoupy_duo.pose 0
scoreboard players set @s survisland.pr_stoupy_duo.sprint 0
scoreboard players set @s survisland.pr_stoupy_duo.moving 0

# The seat carrying the click holder in front of the face, since the head is already taken by the others
execute at @s summon minecraft:item_display run function survisland:modes/pr_stoupy/duo/body/new_seat

execute at @s run function survisland:modes/pr_stoupy/duo/body/setup_sensors

scoreboard players operation @s survisland.pr_stoupy_duo.room = #pr_stoupy_duo_room survisland.data

