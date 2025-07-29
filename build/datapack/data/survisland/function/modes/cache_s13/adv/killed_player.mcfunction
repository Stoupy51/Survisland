
#> survisland:modes/cache_s13/adv/killed_player
#
# @executed	as the player & at current position
#
# @within	advancement survisland:cache_s13/killed_player
#

advancement revoke @s only survisland:cache_s13/killed_player
execute if score §8 survisland.temp.sidebar matches 8 if entity @s[tag=survisland.seeker] run function survisland:modes/cache_s13/adv/add_points

