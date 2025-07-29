
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

title @s title {"translate": "survisland.reste_appuy_sur_jump","color":"gold"}
title @s subtitle {"translate": "survisland.ne_bouge_pas_laisse_toi_prendre","color":"red"}

