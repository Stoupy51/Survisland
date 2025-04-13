
# Debug messages
tag Stoupy51 add convention.debug


# Scoreboard objectives
scoreboard objectives add jn_lobby.data dummy
scoreboard objectives add jn_lobby.leave minecraft.custom:minecraft.leave_game
scoreboard objectives add jn_lobby.trigger.spawn trigger
scoreboard objectives add jn_lobby.trigger.plugins trigger
scoreboard objectives add jn_lobby.timestamp dummy


# JustNoobLobby version
scoreboard players set JustNoobLobby load.status 1000


# Storage for tellraws
data modify storage jn_lobby:main JustNoobWarning set value '[{"text":"[JustNoobWarning]","color":"gold"}]'
data modify storage jn_lobby:main JustNoob set value '[{"text":"[","color":"black"},{"text":"JustNoob","color":"yellow"},{"text":"]","color":"black"}]'


# Gamerules
gamerule doImmediateRespawn true
gamerule doTraderSpawning false
gamerule doDaylightCycle true
gamerule doWeatherCycle false
gamerule keepInventory true
gamerule doMobSpawning false
gamerule mobGriefing false
gamerule fallDamage false
gamerule doInsomnia false
gamerule spawnRadius 0


# Constants
scoreboard players set #2 jn_lobby.data 2
scoreboard players set #8 jn_lobby.data 8
scoreboard players set #9 jn_lobby.data 9
scoreboard players set #10 jn_lobby.data 10
scoreboard players set #13 jn_lobby.data 13
scoreboard players set #24 jn_lobby.data 24
scoreboard players set #60 jn_lobby.data 60
scoreboard players set #100 jn_lobby.data 100
scoreboard players set #3044 jn_lobby.data 3044
scoreboard players set #3600 jn_lobby.data 3600
scoreboard players set #86400 jn_lobby.data 86400
scoreboard players set #2630016 jn_lobby.data 2630016
scoreboard players set #31557600 jn_lobby.data 31557600


# Defines for DatapackHelperPlus
#define storage jn_lobby:main
#define score_holder #success
#define score_holder #valid
#define score_holder #count
#define score_holder #temp
#define score_holder #pos

