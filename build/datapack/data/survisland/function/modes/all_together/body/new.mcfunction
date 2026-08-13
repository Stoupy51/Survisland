
#> survisland:modes/all_together/body/new
#
# @executed	at @a[tag=survisland.all_together,scores={survisland.all_together=1},distance=..50]
#
# @within	survisland:modes/all_together/start [ at @a[tag=survisland.all_together,scores={survisland.all_together=1},distance=..50] ]
#

# Identity and state of this body
tag @s add survisland.all_together.body
data merge entity @s {immovable:0b,hide_description:1b,Invulnerable:1b}
scoreboard players set @s survisland.all_together.phase 0
scoreboard players set @s survisland.all_together.pose 0

execute at @s run function survisland:modes/all_together/body/setup_sensors

