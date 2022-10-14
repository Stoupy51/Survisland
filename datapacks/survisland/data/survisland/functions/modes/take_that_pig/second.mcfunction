
##Fonction executée toutes les secondes lorsque le mode de jeu est activé

schedule function survisland:modes/take_that_pig/second 1s replace



##Take that pig
scoreboard players remove #remaining_time survisland.data 1
execute if score #detect_end survisland.data matches 0 run title @a actionbar [{"text":"Temps restant : ","color":"aqua"},{"score":{"name":"#remaining_time","objective":"survisland.data"},"color":"yellow"},{"text":" secondes"}]
execute if score #detect_end survisland.data matches 0 if predicate survisland:chance/0.2 run summon pig -1220 64 -2806 {Tags:["survisland.to_take"],AbsorptionAmount:2048.0f,DeathLootTable:"none"}
execute if score #detect_end survisland.data matches 0 if predicate survisland:chance/0.1 run summon cow -1220 64 -2806 {Tags:["survisland.to_take"],AbsorptionAmount:2048.0f,DeathLootTable:"none"}
execute if score #detect_end survisland.data matches 0 if predicate survisland:chance/0.1 run summon horse -1220 64 -2806 {Tags:["survisland.to_take"],AbsorptionAmount:2048.0f,DeathLootTable:"none"}
execute if score #detect_end survisland.data matches 0 if predicate survisland:chance/0.1 run summon chicken -1220 64 -2806 {Tags:["survisland.to_take"],AbsorptionAmount:2048.0f,DeathLootTable:"none"}

#Prank de spectateurs
#execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 60 as @a[gamemode=spectator,limit=2,sort=random,tag=!survisland.spec_used] run function survisland:modes/take_that_pig/summon_spectators
#execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 60 run tellraw @a ["\n",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Incroyable ! Deux spectateurs sont apparus, combien de points peuvent-ils donner ?!!!!!"}]
#execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 60 as @a at @s run playsound entity.wither.ambient ambient @s 

#Fin de la pêche
execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 0 run fill -1219 58 -2805 -1221 61 -2807 structure_void replace birch_planks
execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 0 run tp @e[tag=survisland.to_take] -1252 54 -2795
execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 0 run tp @a[tag=survisland.to_take_spec] -1252 54 -2795
execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 0 run spawnpoint @a[tag=survisland.to_take_spec] -1252 54 -2795
execute if score #detect_end survisland.data matches 0 if score #remaining_time survisland.data matches 0 run scoreboard players set #detect_end survisland.data 1



#####################################################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################################################



##Killing mobs
execute if score #detect_end survisland.data matches 1 run scoreboard players set #good survisland.data 1
execute if score #detect_end survisland.data matches 1 at @a[gamemode=adventure] unless block ~ ~-1 ~ glass run scoreboard players set #good survisland.data 0
execute if score #detect_end survisland.data matches 1 if score #good survisland.data matches 1 run fill -1221 55 -2805 -1219 55 -2807 air destroy
#execute if score #detect_end survisland.data matches 1 if score #good survisland.data matches 1 as @a[gamemode=spectator,limit=2,sort=random,tag=!survisland.spec_used] run function survisland:modes/take_that_pig/summon_spectators_killing
#execute if score #detect_end survisland.data matches 1 if score #good survisland.data matches 1 run tellraw @a ["\n",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Wtf, deux autres spectateurs sont apparus, zigouillez-les !"}]
execute if score #detect_end survisland.data matches 1 if score #good survisland.data matches 1 as @a at @s run playsound entity.wither.ambient ambient @s 

#Fin de l'extermination
execute if score #detect_end survisland.data matches 1 run scoreboard players set #good survisland.data 0
execute if score #detect_end survisland.data matches 1 unless entity @e[tag=survisland.to_take] unless entity @a[tag=survisland.to_take_spec] run scoreboard players set #good survisland.data 1
execute if score #detect_end survisland.data matches 1 if score #good survisland.data matches 1 run fill -1268 52 -2793 -1268 55 -2798 air replace emerald_block
execute if score #detect_end survisland.data matches 1 if score #good survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Plus que le parcours vous avez 45 secondes !"}]
execute if score #detect_end survisland.data matches 1 if score #good survisland.data matches 1 as @a at @s run playsound entity.wither.ambient ambient @s 
execute if score #detect_end survisland.data matches 1 if score #good survisland.data matches 1 run scoreboard players set #pos survisland.data 1
execute if score #detect_end survisland.data matches 1 if score #good survisland.data matches 1 run scoreboard players set #mult survisland.data 110
execute if score #detect_end survisland.data matches 1 if score #good survisland.data matches 1 run scoreboard players set #remaining_time survisland.data 45
execute if score #detect_end survisland.data matches 1 if score #good survisland.data matches 1 run scoreboard players set #detect_end survisland.data 2



#####################################################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################################################



##Parcours
execute if score #detect_end survisland.data matches 2 run title @a actionbar [{"text":"Temps restant : ","color":"aqua"},{"score":{"name":"#remaining_time","objective":"survisland.data"},"color":"yellow"},{"text":" secondes"}]
execute if score #detect_end survisland.data matches 2 as @a[gamemode=adventure,tag=!survisland.finished] at @s if block ~ ~-1 ~ gold_block run function survisland:modes/take_that_pig/parkour_end
execute if score #detect_end survisland.data matches 2 if score #remaining_time survisland.data matches 0 run scoreboard players set #detect_end survisland.data 3
execute if score #detect_end survisland.data matches 2 unless entity @a[gamemode=adventure,tag=!survisland.finished] run scoreboard players set #detect_end survisland.data 3



