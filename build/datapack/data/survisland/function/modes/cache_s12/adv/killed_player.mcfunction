
#> survisland:modes/cache_s12/adv/killed_player
#
# @within	???
#

advancement revoke @s only survisland:killed_player_cache_cache
execute if score T survisland.temp.sidebar matches 8 if entity @s[tag=survisland.seeker] run function survisland:modes/cache_s12/adv/add_points

