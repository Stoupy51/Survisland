
#> survisland:modes/pr_stoupy/villager/here/place
#
# @within	???
#

# Replace any villager of the lab standing here, facing the rotation of the caller
kill @e[tag=survisland.pr_stoupy.villager,distance=..2]
summon minecraft:villager ~ ~ ~ {Tags:["survisland.pr_stoupy.villager"],NoAI:1b,Invulnerable:1b,Silent:1b,PersistenceRequired:1b,CustomName:"Maarcouscous",CustomNameVisible:1b,VillagerData:{profession:"minecraft:nitwit",level:1,type:"minecraft:plains"},equipment:{head:{id:"minecraft:player_head",count:1,components:{"minecraft:profile":"Maarcouscous"}}},drop_chances:{head:0.0f}}
execute as @n[type=villager,tag=survisland.pr_stoupy.villager,distance=..1] run rotate @s ~ 0

# The interaction box encloses the villager, so every click lands on it instead of opening the trades
summon minecraft:interaction ~ ~ ~ {Tags:["survisland.pr_stoupy.villager"],width:0.9f,height:2.1f,response:1b}

