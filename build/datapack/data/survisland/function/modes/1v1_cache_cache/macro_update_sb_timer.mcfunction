
#> survisland:modes/1v1_cache_cache/macro_update_sb_timer
#
# @within	survisland:modes/1v1_cache_cache/update_sidebar_timer with storage survisland:main input
#
# @args		add_m (string)
#			minutes (int)
#			add_s (string)
#			seconds (int)
#

$team modify survisland.temp.sidebar.8 suffix [{"text":"Temps restant : "},{"text":"$(add_m)$(minutes)","color":"gray"},{"text":"m"},{"text":"$(add_s)$(seconds)","color":"gray"},{"text":"s"}]

