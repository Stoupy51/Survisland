
$execute if entity @s[team=$(team1_id)] run scoreboard players add #$(team1_id)_points survisland.data 10
$execute if entity @s[team=$(team2_id)] run scoreboard players add #$(team2_id)_points survisland.data 10
$execute if entity @s[team=$(team3_id)] run scoreboard players add #$(team3_id)_points survisland.data 10
function survisland:modes/1v1v1_cache_cache/update_sidebar_points with storage survisland:main cache_cache_config

