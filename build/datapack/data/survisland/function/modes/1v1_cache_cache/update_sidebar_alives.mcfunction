
#> survisland:modes/1v1_cache_cache/update_sidebar_alives
#
# @within	survisland:modes/1v1_cache_cache/macro_tick with storage survisland:main cache_cache_config
#
# @args		specs_remaining (unknown)
#			team1_color (unknown)
#			team1_remaining (unknown)
#			team2_color (unknown)
#			team2_remaining (unknown)
#

$team modify survisland.temp.sidebar.7 suffix [{"text":"Specs restants : ","color":"gray"},{"text":"$(specs_remaining)","color":"white"}]
$team modify survisland.temp.sidebar.5 suffix [{"text":"Joueurs restants : ","color":"$(team1_color)"},{"text":"$(team1_remaining)","color":"yellow"}]
$team modify survisland.temp.sidebar.2 suffix [{"text":"Joueurs restants : ","color":"$(team2_color)"},{"text":"$(team2_remaining)","color":"yellow"}]

