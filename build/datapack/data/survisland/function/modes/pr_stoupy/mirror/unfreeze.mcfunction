
#> survisland:modes/pr_stoupy/mirror/unfreeze
#
# @executed	as @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_pair]
#
# @within	survisland:modes/pr_stoupy/mirror/reset_body
#			survisland:modes/pr_stoupy/mirror/toggle_body
#

scoreboard players set @s survisland.pr_mirror.frozen 0
data remove entity @s profile.texture
execute at @s run playsound minecraft:block.beacon.activate ambient @a[distance=..48] ~ ~ ~ 1 1.6
title @a[tag=survisland.pr_mirror,predicate=survisland:modes/pr_stoupy/mirror/same_pair] actionbar {"text":"Reflet libéré","color":"green"}

