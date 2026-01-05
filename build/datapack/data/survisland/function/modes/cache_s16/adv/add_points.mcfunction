
#> survisland:modes/cache_s16/adv/add_points
#
# @within	survisland:modes/cache_s16/adv/killed_player
#

execute if entity @s[team=mLiwai] run scoreboard players add #mLiwai_points survisland.data 10
execute if entity @s[team=mMoemoea] run scoreboard players add #mMoemoea_points survisland.data 10
function survisland:modes/cache_s16/update_sidebar_points

