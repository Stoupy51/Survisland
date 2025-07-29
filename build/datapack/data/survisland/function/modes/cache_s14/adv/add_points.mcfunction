
#> survisland:modes/cache_s14/adv/add_points
#
# @executed	as the player & at current position
#
# @within	survisland:modes/cache_s14/adv/killed_player
#

execute if entity @s[team=mPonogoro] run scoreboard players add #mPonogoro_points survisland.data 10
execute if entity @s[team=mKecak] run scoreboard players add #mKecak_points survisland.data 10
execute if entity @s[team=mSinaoh] run scoreboard players add #mSinaoh_points survisland.data 10
function survisland:modes/cache_s14/update_sidebar_points

