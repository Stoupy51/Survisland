
tag @s remove survisland.laser_game.blue
tag @s remove survisland.laser_game.red
tag @s remove global.ignore

attribute @s generic.attack_speed base set 1024
xp set @s 100 levels
xp set @s 740 points

## mPeluang VS mTuarua
## mAkijan VS mHainy
execute if entity @s[tag=mPeluang] in overworld run tp @s -1220 57 -2813 45 0
execute if entity @s[tag=mPeluang] run team join survisland.laser_game.blue @s
execute if entity @s[tag=mPeluang] run tag @s add survisland.laser_game.blue
execute if entity @s[tag=mAkijan] in overworld run tp @s -1220 57 -2813 45 0
execute if entity @s[tag=mAkijan] run team join survisland.laser_game.blue @s
execute if entity @s[tag=mAkijan] run tag @s add survisland.laser_game.blue
execute if entity @s[tag=mTuarua] in overworld run tp @s -1268 57 -2765 -135 0
execute if entity @s[tag=mTuarua] run team join survisland.laser_game.red @s
execute if entity @s[tag=mTuarua] run tag @s add survisland.laser_game.red
execute if entity @s[tag=mHainy] in overworld run tp @s -1268 57 -2765 -135 0
execute if entity @s[tag=mHainy] run team join survisland.laser_game.red @s
execute if entity @s[tag=mHainy] run tag @s add survisland.laser_game.red


