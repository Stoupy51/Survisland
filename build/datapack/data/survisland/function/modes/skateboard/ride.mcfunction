
#> survisland:modes/skateboard/ride
#
# @executed	as @a[gamemode=!spectator,tag=!survisland.skateboard] & at @s & positioned ~ ~2 ~
#
# @within	survisland:modes/skateboard/tick [ as @a[gamemode=!spectator,tag=!survisland.skateboard] & at @s & positioned ~ ~2 ~ ]
#

tag @s add survisland.skateboard
tag @p[gamemode=!spectator,tag=!survisland.skateboard,distance=..1] add survisland.skateboard
playsound entity.experience_orb.pickup ambient @a[distance=..10]
particle happy_villager ~ ~ ~ .5 .5 .5 .1 10 normal @a[distance=..10]

