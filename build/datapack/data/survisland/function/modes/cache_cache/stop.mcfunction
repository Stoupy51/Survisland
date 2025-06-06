
#> survisland:modes/cache_cache/stop
#
# @within	survisland:modes/cache_cache/process_end
#

tag @a remove survisland.alive
tag @a remove survisland.dead
tag @a remove survisland.seeker

team remove survisland.temp.sidebar.8
team remove survisland.temp.sidebar.7
team remove survisland.temp.sidebar.6
team remove survisland.temp.sidebar.5
team remove survisland.temp.sidebar.4
team remove survisland.temp.sidebar.3
team remove survisland.temp.sidebar.2
team remove survisland.temp.sidebar.1
scoreboard objectives remove survisland.temp.death_count
scoreboard objectives remove survisland.temp.heart_beat
scoreboard objectives remove survisland.temp.sidebar

schedule clear survisland:modes/cache_cache/tick
schedule clear survisland:modes/cache_cache/second

