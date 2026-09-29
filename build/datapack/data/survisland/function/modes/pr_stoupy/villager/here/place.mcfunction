
#> survisland:modes/pr_stoupy/villager/here/place
#
# @within	???
#

# Replace any villager of the lab spawned here, facing the rotation of the caller, then free to wander off and be found again
kill @e[tag=survisland.pr_stoupy.villager,distance=..2]
summon minecraft:marker ~ ~ ~ {Tags:["survisland.pr_stoupy.villager","survisland.pr_stoupy.villager.spawn"]}
summon minecraft:villager ~ ~ ~ {Tags:["survisland.pr_stoupy.villager"],Invulnerable:1b,Silent:1b,PersistenceRequired:1b,CustomName:"Maarcouscous",CustomNameVisible:1b,VillagerData:{profession:"minecraft:nitwit",level:1,type:"minecraft:plains"},equipment:{head:{id:"minecraft:player_head",count:1,components:{"minecraft:profile":"Maarcouscous"}}},drop_chances:{head:0.0f}}
execute as @n[type=villager,tag=survisland.pr_stoupy.villager,distance=..1] run rotate @s ~ 0

