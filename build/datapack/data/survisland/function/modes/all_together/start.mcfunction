
#> survisland:modes/all_together/start
#
# @within	???
#

tellraw @a[distance=..50] ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Vous ne faites plus qu'un ! Chacun n'a qu'une partie des commandes."}]

# Objectives of the mode, the last four are carried by the mannequins themselves
scoreboard objectives add survisland.all_together dummy
scoreboard objectives add survisland.all_together.phase dummy
scoreboard objectives add survisland.all_together.pose dummy
scoreboard objectives add survisland.all_together.sprint dummy

# Speeds shared by every group, in thousandths of a block per tick
scoreboard players set #all_together_speed_walk survisland.data 216
scoreboard players set #all_together_speed_sprint survisland.data 280
scoreboard players set #all_together_speed_back survisland.data 130
scoreboard players set #all_together_speed_sneak survisland.data 65

# A group may already be running here, it is properly stopped before being replaced
execute as @e[type=mannequin,tag=survisland.all_together.body,distance=..50] at @s run function survisland:modes/all_together/body/stop
function survisland:modes/all_together/body/clear_group

# The four nearest players become the controllers of this zone
scoreboard players set #all_together_slot survisland.data 0
execute as @a[distance=..50,gamemode=!creative,gamemode=!spectator,limit=4,sort=nearest] run function survisland:modes/all_together/body/enroll_player

# Their body is summoned on the first of them, never on the caller which may be a command block inside a wall
execute at @a[tag=survisland.all_together,scores={survisland.all_together=1},distance=..50] summon minecraft:mannequin run function survisland:modes/all_together/body/new

schedule function survisland:modes/all_together/tick 1t replace

