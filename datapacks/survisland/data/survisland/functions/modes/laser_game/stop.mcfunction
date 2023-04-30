
kill @e[tag=survisland.laser_game.base]
schedule clear survisland:modes/laser_game/tick
schedule clear survisland:modes/laser_game/second
clear @a warped_fungus_on_a_stick
clear @a leather_chestplate

tag @a remove survisland.laser_game.blue
tag @a remove survisland.laser_game.red
tag @a remove global.ignore
scoreboard objectives remove survisland.temp.individual_points
scoreboard objectives remove survisland.temp.shield
scoreboard objectives remove survisland.temp.cooldown
scoreboard objectives remove survisland.temp.dead_cooldown
scoreboard objectives remove survisland.temp.sidebar
team remove survisland.laser_game.blue
team remove survisland.laser_game.red
team remove survisland.temp.sidebar.1
team remove survisland.temp.sidebar.2
team remove survisland.temp.sidebar.3

