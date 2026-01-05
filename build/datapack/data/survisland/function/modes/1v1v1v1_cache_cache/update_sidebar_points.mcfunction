
#> survisland:modes/1v1v1v1_cache_cache/update_sidebar_points
#
# @executed	as the player & at current position
#
# @within	survisland:modes/1v1v1v1_cache_cache/adv/add_points with storage survisland:main cache_cache_config
#			survisland:modes/1v1v1v1_cache_cache/process_end with storage survisland:main cache_cache_config
#			survisland:modes/1v1v1v1_cache_cache/second with storage survisland:main cache_cache_config
#
# @args		team1_id (unknown)
#			team2_id (unknown)
#			team3_id (unknown)
#			team4_id (unknown)
#

$execute store result storage survisland:main cache_cache_config.team1_points int 1 run scoreboard players get #$(team1_id)_points survisland.data
$execute store result storage survisland:main cache_cache_config.team2_points int 1 run scoreboard players get #$(team2_id)_points survisland.data
$execute store result storage survisland:main cache_cache_config.team3_points int 1 run scoreboard players get #$(team3_id)_points survisland.data
$execute store result storage survisland:main cache_cache_config.team4_points int 1 run scoreboard players get #$(team4_id)_points survisland.data
function survisland:modes/1v1v1v1_cache_cache/macro_update_sb_points with storage survisland:main cache_cache_config

