
#> survisland:modes/take_that_pig/summon_spectators
#
# @executed	as @a[gamemode=spectator,limit=2,sort=random,tag=!survisland.spec_used]
#
# @within	survisland:modes/take_that_pig/second [ as @a[gamemode=spectator,limit=2,sort=random,tag=!survisland.spec_used] ]
#

tag @s add survisland.spec_used
tag @s add survisland.to_take_spec
gamemode adventure @s
effect clear @s
tp @s -1220 64 -2806

title @s title {"text":"Reste appuyé sur Jump","color":"gold"}
title @s subtitle {"text":"Ne bouge pas, laisse-toi prendre","color":"red"}

