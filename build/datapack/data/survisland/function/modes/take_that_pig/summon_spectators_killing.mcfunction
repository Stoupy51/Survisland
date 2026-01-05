
#> survisland:modes/take_that_pig/summon_spectators_killing
#
# @executed	as @a[gamemode=spectator,limit=2,sort=random,tag=!survisland.spec_used]
#
# @within	survisland:modes/take_that_pig/second [ as @a[gamemode=spectator,limit=2,sort=random,tag=!survisland.spec_used] ]
#

tag @s add survisland.spec_used
tag @s add survisland.to_take_spec
gamemode adventure @s
effect clear @s
tp @s -1252 54 -2795
spawnpoint @s -1252 54 -2795

title @s title {"text":"Essaie de rester en vie x)","color":"gold"}

