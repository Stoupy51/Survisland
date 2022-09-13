
## mPeluang VS mTuarua
## mAkijan VS mHainy
team join mPeluang @a[tag=mPeluang]
team join mTuarua @a[tag=mTuarua]
team join mHainy @a[tag=mHainy]
team join mAkijan @a[tag=mAkijan]

tag @a remove survisland.laser_game.blue
tag @a remove survisland.laser_game.red
tag @a remove global.ignore
scoreboard objectives remove survisland.temp.kills
scoreboard objectives remove survisland.temp.shield
scoreboard objectives remove survisland.temp.cooldown
scoreboard objectives remove survisland.temp.dead_cooldown
scoreboard objectives remove survisland.temp.sidebar
team remove survisland.laser_game.blue
team remove survisland.laser_game.red
team remove survisland.temp.sidebar.1
team remove survisland.temp.sidebar.2
team remove survisland.temp.sidebar.3

clear @a warped_fungus_on_a_stick
clear @a leather_chestplate

schedule clear survisland:modes/laser_game/tick
schedule clear survisland:modes/laser_game/second

