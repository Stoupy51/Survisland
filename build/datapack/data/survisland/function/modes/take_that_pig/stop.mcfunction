
#> survisland:modes/take_that_pig/stop
#
# @within	survisland:modes/take_that_pig/process_end
#

tag @a remove survisland.spec_used
tag @a remove survisland.finished
team modify mMerge friendlyFire true
scoreboard objectives remove survisland.temp.sidebar
scoreboard objectives remove survisland.temp.color
scoreboard players reset #game survisland.data
gamerule doImmediateRespawn false

schedule clear survisland:modes/take_that_pig/tick
schedule clear survisland:modes/take_that_pig/second

