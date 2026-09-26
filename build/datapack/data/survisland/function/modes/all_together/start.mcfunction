
#> survisland:modes/all_together/start
#
# @within	???
#

# Objectives of the mode, all but the first one are carried by the mannequins themselves
scoreboard objectives add survisland.all_together dummy
scoreboard objectives add survisland.all_together.group dummy
scoreboard objectives add survisland.all_together.phase dummy
scoreboard objectives add survisland.all_together.pose dummy
scoreboard objectives add survisland.all_together.sprint dummy
scoreboard objectives add survisland.all_together.moving dummy

# Speeds shared by every group, in thousandths of a block per tick
scoreboard players set #all_together_speed_walk survisland.data 216
scoreboard players set #all_together_speed_sprint survisland.data 281
scoreboard players set #all_together_speed_back survisland.data 130
scoreboard players set #all_together_speed_sneak survisland.data 65

# Nothing happens until enough free players stand here, so a group already playing is never disturbed
execute store result score #all_together_free survisland.data if entity @a[tag=!survisland.all_together,distance=..3,gamemode=!creative,gamemode=!spectator]
execute if score #all_together_free survisland.data matches ..3 run return 0

# The nearest free players are split into groups, each one taking the closest players still free
function survisland:modes/all_together/body/form_group

schedule function survisland:modes/all_together/tick 1t replace

