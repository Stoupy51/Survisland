
#> survisland:modes/1v1v1v1_cache_cache/macro_update_sb_points
#
# @executed	as the player & at current position
#
# @within	survisland:modes/1v1v1v1_cache_cache/update_sidebar_points with storage survisland:main cache_cache_config
#

$team modify survisland.temp.sidebar.10 suffix [{"text":"Points : ","color":"$(team4_color)"},{"text":"$(team4_points)","color":"yellow"}]
$team modify survisland.temp.sidebar.7 suffix [{"text":"Points : ","color":"$(team3_color)"},{"text":"$(team3_points)","color":"yellow"}]
$team modify survisland.temp.sidebar.4 suffix [{"text":"Points : ","color":"$(team2_color)"},{"text":"$(team2_points)","color":"yellow"}]
$team modify survisland.temp.sidebar.1 suffix [{"text":"Points : ","color":"$(team1_color)"},{"text":"$(team1_points)","color":"yellow"}]

