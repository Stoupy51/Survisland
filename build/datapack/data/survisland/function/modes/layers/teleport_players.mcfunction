
#> survisland:modes/layers/teleport_players
#
# @executed	as @a[sort=random,team=!zStaff]
#
# @within	survisland:modes/layers/tick [ as @a[sort=random,team=!zStaff] ]
#

effect clear @s
attribute @s attack_speed base set 1024
xp set @s 0 levels
xp set @s 0 points

## mAkijan VS mHainy
execute at @s run particle cloud ~ ~ ~ 2 0.2 2 0 1000 force
execute if entity @s[team=mHainy] in overworld run tp @s -1232 110 -2787 -90 0
execute if entity @s[team=mAkijan] in overworld run tp @s -1213 110 -2787 90 0

