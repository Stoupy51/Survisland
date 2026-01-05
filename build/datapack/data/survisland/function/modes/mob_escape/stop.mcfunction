
#> survisland:modes/mob_escape/stop
#
# @within	survisland:modes/mob_escape/process_end
#

tag @a remove survisland.alive
scoreboard objectives remove survisland.temp.sidebar

schedule clear survisland:modes/mob_escape/tick
schedule clear survisland:modes/mob_escape/second

