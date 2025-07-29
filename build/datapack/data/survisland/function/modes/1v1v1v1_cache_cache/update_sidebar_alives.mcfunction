
#> survisland:modes/1v1v1v1_cache_cache/update_sidebar_alives
#
# @within	survisland:modes/1v1v1v1_cache_cache/macro_tick with storage survisland:main cache_cache_config
#

$team modify survisland.temp.sidebar.13 suffix [{"translate": "survisland.specs_restants","color":"gray"},{"text":"$(specs_remaining)","color":"white"}]
$team modify survisland.temp.sidebar.11 suffix [{"translate": "survisland.joueurs_restants","color":"$(team4_color)"},{"text":"$(team4_remaining)","color":"yellow"}]
$team modify survisland.temp.sidebar.8 suffix [{"translate": "survisland.joueurs_restants","color":"$(team3_color)"},{"text":"$(team3_remaining)","color":"yellow"}]
$team modify survisland.temp.sidebar.5 suffix [{"translate": "survisland.joueurs_restants","color":"$(team2_color)"},{"text":"$(team2_remaining)","color":"yellow"}]
$team modify survisland.temp.sidebar.2 suffix [{"translate": "survisland.joueurs_restants","color":"$(team1_color)"},{"text":"$(team1_remaining)","color":"yellow"}]

