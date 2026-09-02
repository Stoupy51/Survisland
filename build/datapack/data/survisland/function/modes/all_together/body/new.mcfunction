
#> survisland:modes/all_together/body/new
#
# @executed	at @a[tag=survisland.all_together.new,scores={survisland.all_together=1},limit=1]
#
# @within	survisland:modes/all_together/start [ at @a[tag=survisland.all_together.new,scores={survisland.all_together=1},limit=1] ]
#

# Identity and state of this body
tag @s add survisland.all_together.body
data merge entity @s {immovable:0b,hide_description:1b,Invulnerable:1b,profile:"GoldVision98"}
scoreboard players operation @s survisland.all_together.group = #all_together_group_counter survisland.data
scoreboard players set @s survisland.all_together.phase 0
scoreboard players set @s survisland.all_together.pose 0
scoreboard players set @s survisland.all_together.sprint 0
scoreboard players set @s survisland.all_together.moving 0

# The seat carrying the click holder in front of the face, since the head is already taken by the others
execute at @s summon minecraft:item_display run function survisland:modes/all_together/body/new_seat

execute at @s run function survisland:modes/all_together/body/setup_sensors

