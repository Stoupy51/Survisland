
#> survisland:modes/pr_stoupy/mirror/freeze
#
# @executed	as @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_pair]
#
# @within	survisland:modes/pr_stoupy/mirror/toggle_body
#

scoreboard players set @s survisland.pr_mirror.frozen 1
scoreboard players set @s survisland.pr_mirror.moving 0
data modify entity @s Motion[0] set value 0.0d
data modify entity @s Motion[2] set value 0.0d
data modify entity @s profile.texture set value "survisland:entity/pr_stoupy/hologram"
execute at @s run playsound minecraft:block.beacon.deactivate ambient @a[distance=..48] ~ ~ ~ 1 1.6
execute at @s run particle minecraft:electric_spark ~ ~1 ~ 0.3 0.6 0.3 0.1 30
title @a[tag=survisland.pr_mirror,predicate=survisland:modes/pr_stoupy/mirror/same_pair] actionbar {"text":"Reflet figé","color":"aqua"}

