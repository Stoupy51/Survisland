
#> survisland:modes/cache_s12/adv/add_points
#
# @within	survisland:modes/cache_s12/adv/killed_player
#

execute if entity @s[team=mKuning] run scoreboard players add #mKuning_points survisland.data 10
execute if entity @s[team=mMayra] run scoreboard players add #mMayra_points survisland.data 10
function survisland:modes/cache_s12/update_sidebar_points

