
#> survisland:modes/cache_s13/adv/add_points
#
# @executed	as the player & at current position
#
# @within	survisland:modes/cache_s13/adv/killed_player
#

execute if entity @s[team=mSambor] run scoreboard players add #mSambor_points survisland.data 10
execute if entity @s[team=mKanawa] run scoreboard players add #mKanawa_points survisland.data 10
function survisland:modes/cache_s13/update_sidebar_points

