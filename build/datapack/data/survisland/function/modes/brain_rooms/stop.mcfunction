
#> survisland:modes/brain_rooms/stop
#
# @within	survisland:modes/brain_rooms/process_end
#

team remove survisland.temp.sidebar.3
team remove survisland.temp.sidebar.2
team remove survisland.temp.sidebar.1
scoreboard objectives remove survisland.temp.sidebar
execute as @a[gamemode=adventure] run gamemode survival @s

schedule clear survisland:modes/brain_rooms/tick

