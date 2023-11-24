
kill @e[tag=survisland.quake.base]
schedule clear survisland:modes/quake/tick
schedule clear survisland:modes/quake/second
clear @a warped_fungus_on_a_stick
clear @a leather_chestplate

tag @a remove survisland.quake.blue
tag @a remove survisland.quake.red
tag @a remove global.ignore
scoreboard objectives remove survisland.temp.points
scoreboard objectives remove survisland.temp.shield
scoreboard objectives remove survisland.temp.cooldown
scoreboard objectives remove survisland.temp.dead_cooldown
scoreboard objectives remove survisland.temp.sidebar
team remove survisland.quake.blue
team remove survisland.quake.red
team remove survisland.temp.sidebar.1
team remove survisland.temp.sidebar.2
team remove survisland.temp.sidebar.3

