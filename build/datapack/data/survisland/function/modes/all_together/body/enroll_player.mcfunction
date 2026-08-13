
#> survisland:modes/all_together/body/enroll_player
#
# @executed	as @a[distance=..50,gamemode=!creative,limit=4,sort=nearest]
#
# @within	survisland:modes/all_together/start [ as @a[distance=..50,gamemode=!creative,limit=4,sort=nearest] ]
#

scoreboard players add #all_together_slot survisland.data 1
scoreboard players operation @s survisland.all_together = #all_together_slot survisland.data
tag @s add survisland.all_together

