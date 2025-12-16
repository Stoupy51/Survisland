
#> survisland:modes/1v1_cache_cache/adv/add_points
#
# @executed	as the player & at current position
#
# @within	survisland:modes/1v1_cache_cache/adv/killed_player with storage survisland:main cache_cache_config
#
# @args		team1_id (unknown)
#			team2_id (unknown)
#

$execute if entity @s[team=$(team1_id)] run scoreboard players add #$(team1_id)_points survisland.data 10
$execute if entity @s[team=$(team2_id)] run scoreboard players add #$(team2_id)_points survisland.data 10
function survisland:modes/1v1_cache_cache/update_sidebar_points with storage survisland:main cache_cache_config

