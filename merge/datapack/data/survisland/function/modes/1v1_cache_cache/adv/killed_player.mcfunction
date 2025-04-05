
advancement revoke @s only survisland:1v1_cache_cache/killed_player
execute if score #1v1_cache_cache_ticks survisland.data matches 1.. if entity @s[tag=survisland.seeker] run function survisland:modes/1v1_cache_cache/adv/add_points with storage survisland:main cache_cache_config

