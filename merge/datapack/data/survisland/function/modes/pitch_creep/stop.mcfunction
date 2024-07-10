
tag @a remove survisland.alive
tag @a remove survisland.dead
clear @a #survisland:layers[minecraft:custom_data={survisland:{pitch_creep:1b}}]
execute as @a run attribute @s generic.attack_speed base set 4.0

team remove survisland.temp.sidebar.3
team remove survisland.temp.sidebar.2
team remove survisland.temp.sidebar.1
scoreboard objectives remove survisland.temp.deathCount
scoreboard objectives remove survisland.temp.sidebar

schedule clear survisland:modes/pitch_creep/tick
schedule clear survisland:modes/pitch_creep/second

