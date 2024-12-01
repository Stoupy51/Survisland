
## mPeluang VS mTuarua
## mAkijan VS mHainy
team modify mHainy nametagVisibility hideForOwnTeam
team modify mAkijan nametagVisibility hideForOwnTeam
team modify mHainy friendlyFire true
team modify mAkijan friendlyFire true

execute as @a run attribute @s attack_speed base set 4.0
clear @a #survisland:layers

team remove survisland.temp.sidebar.2
team remove survisland.temp.sidebar.1
scoreboard objectives remove survisland.temp.deathCount
scoreboard objectives remove survisland.temp.sidebar

schedule clear survisland:modes/layers/tick

