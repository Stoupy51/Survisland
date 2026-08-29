
#> survisland:modes/all_together/start
#
# @within	???
#

# Objectives of the mode, the last three are carried by the mannequins themselves
scoreboard objectives add survisland.all_together dummy
scoreboard objectives add survisland.all_together.phase dummy
scoreboard objectives add survisland.all_together.pose dummy
scoreboard objectives add survisland.all_together.sprint dummy

# Speeds shared by every group, in thousandths of a block per tick
scoreboard players set #all_together_speed_walk survisland.data 216
scoreboard players set #all_together_speed_sprint survisland.data 280
scoreboard players set #all_together_speed_back survisland.data 130
scoreboard players set #all_together_speed_sneak survisland.data 65

# Nothing happens until enough free players stand here, so a group already playing is never disturbed
execute store result score #all_together_free survisland.data if entity @a[distance=..5,tag=!survisland.all_together,gamemode=!creative,gamemode=!spectator]
execute if score #all_together_free survisland.data matches ..3 run return 0

# The nearest free players become the controllers of this new group, the closest one being the Joueur 1
scoreboard players set #all_together_slot survisland.data 0
execute as @a[distance=..5,tag=!survisland.all_together,gamemode=!creative,gamemode=!spectator,limit=4,sort=nearest] run function survisland:modes/all_together/body/enroll_player

# Their body is summoned on the Joueur 1, never on the caller which may be a command block inside a wall
execute at @a[tag=survisland.all_together.new,scores={survisland.all_together=1},limit=1] summon minecraft:mannequin run function survisland:modes/all_together/body/new
tag @a[tag=survisland.all_together.new] remove survisland.all_together.new

schedule function survisland:modes/all_together/tick 1t replace

